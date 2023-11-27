extends Node3D

# Preloaded FBX models for numbers 0-9
var number_models = [
	preload("res://Assets/3d_assets/3d_0.fbx"),
	preload("res://Assets/3d_assets/3d_1.fbx"),
	preload("res://Assets/3d_assets/3d_2.fbx"),
	preload("res://Assets/3d_assets/3d_3.fbx"),
	preload("res://Assets/3d_assets/3d_4.fbx"),
	preload("res://Assets/3d_assets/3d_5.fbx"),
	preload("res://Assets/3d_assets/3d_6.fbx"),
	preload("res://Assets/3d_assets/3d_7.fbx"),
	preload("res://Assets/3d_assets/3d_8.fbx"),
	preload("res://Assets/3d_assets/3d_9.fbx")
]

@export var proximity_numbers:Array[PackedScene]

func _ready():
	# Example usage
	initialize_proximity_number(1)

func initialize_proximity_number(number: int) -> void:
	# Clear existing number model
	clear_current_number()

	# Check if the number is within the valid range
	if number < 0 or number >= number_models.size():
		print("Number out of range")
		return

	var number_instance = proximity_numbers[number].instantiate()
	# Instance the corresponding number model
	add_child(number_instance)

func clear_current_number() -> void:
	# This function will remove the last number added as a child
	for child in get_children():
		remove_child(child)
		child.queue_free()
