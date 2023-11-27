extends CharacterBody3D

# player nodes
@onready var head = $Head
@onready var standing_coll_shape = $standing_coll_shape
@onready var crouching_coll_shape = $crouching_coll_shape
@onready var ray_cast_3d = $RayCast3D

# speed vars

@export var current_speed = 5.0

@export var walk_speed = 5.0
@export var sprint_speed = 8.0
@export var crouch_speed = 3.0

# movement vars

@export var is_crouching = false
var crouching_depth = -0.8
const jump_velocity = 4.5

var lerp_speed = 10.0

# input vars

var direction = Vector3.ZERO
const mouse_sens = 0.2


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _init():
	pass

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	# mouse looking logic
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _physics_process(delta):
	
	# handle movement state
	
	if Input.is_action_just_pressed("crouch") && !ray_cast_3d.is_colliding():
		is_crouching = !is_crouching
		
	if is_crouching:
		# crouching
		current_speed = crouch_speed
		head.position.y = lerp(head.position.y, 1.8 + crouching_depth, delta * lerp_speed)
		standing_coll_shape.disabled = true
		crouching_coll_shape.disabled = false
	elif !ray_cast_3d.is_colliding():
		# standing
		head.position.y = lerp(head.position.y, 1.8, delta * lerp_speed)
		standing_coll_shape.disabled = false
		crouching_coll_shape.disabled = true
	
	if Input.is_action_pressed("sprint"):
		# sprinting
		current_speed = sprint_speed
		is_crouching = false
	elif !is_crouching:
		# walking
		current_speed = walk_speed	
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	direction = lerp(direction,(transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(),delta*lerp_speed)
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()
