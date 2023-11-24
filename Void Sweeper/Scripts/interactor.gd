extends RayCast3D

var interactable_detected = false
var interactable_group = "block"  # Replace with your group name

func _process(delta):
	if is_colliding():
		var collider = get_collider()
		# Check if the collider is in the specified group
		if collider and collider.is_in_group("block"):
			interactable_detected = true
			print("interactable_detected = " + str(interactable_detected))
		else:
			interactable_detected = false
	else:
		interactable_detected = false
	
