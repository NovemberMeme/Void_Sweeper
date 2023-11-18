extends Node3D

class_name grid

# Properties
var grid_array: Array

var mine_percentage: float = 0.15 # Percentage of total blocks that will be mines
var safe_block_percentage: float = 0.10 # Percentage of total blocks that will be safe
var grid_size: Vector3i = Vector3i(10,10,10)

# Dependencies (you need to set these in the editor or via code)
# These are the PackedScenes for your blocks
var block_scene = preload("res://Scenes/block.tscn")
@export var block_packedscene: PackedScene
var mine_block_scene: PackedScene
var safe_block_scene: PackedScene

func ready():
	grid_size = Vector3i(grid_size.x, grid_size.y, grid_size.z)
	grid_array = []
	_create_grid()
	print("_create_grid")

# Private method to create the grid
func _create_grid():
	for x in range(grid_size.x):
		var grid_y = []
		for y in range(grid_size.y):
			var grid_z = []
			for z in range(grid_size.z):
				var block = _create_block(Vector3i(x, y, z))
				grid_z.append(block)
			grid_y.append(grid_z)
		grid.append(grid_y)

func _create_block(newblock_index: Vector3i) -> block:
	print(newblock_index)
	# Create and position the block instance
	#var newblock_instance = block_scene.instantiate()
	var newblock_instance = block_packedscene.instantiate() as block
	newblock_instance.global_transform.origin = newblock_index
	newblock_instance.initialize_block(newblock_index)
	# Add the block instance as a child of the GridManager
	add_child(newblock_instance)
	return newblock_instance
	
func get_block_at(pos: Vector3):
	pass
	
# Method to set up the game
func setup_game():
	_place_mines_and_safe_blocks()
	_calculate_proximity_numbers()

# Method to place mines and safe blocks
func _place_mines_and_safe_blocks():
	var total_blocks = int(grid_size.x * grid_size.y * grid_size.z)
	var mine_count = int(total_blocks * mine_percentage)
	var safe_count = int(total_blocks * safe_block_percentage)

	# Randomly place mines
	for i in range(mine_count):
		var random_position = _get_random_grid_position()
		var mine_block = get_block_at(random_position)
		mine_block.is_mine = true

	# Randomly place safe blocks
	for i in range(safe_count):
		var random_position = _get_random_grid_position()
		var safe_block = get_block_at(random_position)
		safe_block.is_safe = true

# Method to calculate proximity numbers
func _calculate_proximity_numbers():
	# Loop through each block and calculate proximity numbers
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			for z in range(grid_size.z):
				var block = get_block_at(Vector3(x, y, z))
				block.proximity_number = _get_mine_count_around(block)

# Helper method to get a random grid position
func _get_random_grid_position() -> Vector3:
	var x = randi() % grid_size.x
	var y = randi() % grid_size.y
	var z = randi() % grid_size.z
	return Vector3(x, y, z)
	
#func _get_random_safe_grid_position() -> Vector3:
	

# Helper method to get the count of mines around a block
func _get_mine_count_around(block: block) -> int:
	var count = 0
	# Check adjacent blocks for mines and increment count
	# You'll need to implement this based on your game's logic
	return count
