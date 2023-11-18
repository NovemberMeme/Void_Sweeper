extends Node3D

# Define the Block class
class_name block

enum eblock_type{
	safe,
	unknown,
	mine
}

# Properties
var myblock_index:Vector3i
var proximity_number: int = 0
var myblock_type: eblock_type = eblock_type.unknown

# This method can be called to initialize the block's properties
func initialize_block(block_index:Vector3i):
	myblock_index = block_index
	myblock_type = eblock_type.unknown
	pass
	
func set_block_type(block_type:eblock_type):
	myblock_type = block_type
	
	match myblock_type:
		eblock_type.safe:
			pass
		eblock_type.mine:
			pass
			
func update_proximity_number():
	pass

# Override the _ready method if you need to initialize anything when the block is ready
func _ready():
	# Initialization code here, if necessary
	pass

# Method to handle player interaction, e.g., when a player clicks the block
func interact():
	match myblock_type:
		eblock_type.safe:
			pass
		eblock_type.unknown:
			pass
		eblock_type.mine:
			pass

