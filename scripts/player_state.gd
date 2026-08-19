extends Label

func _update_label(_player_state: int) -> void:
	text = "State: " + str(_player_state)
