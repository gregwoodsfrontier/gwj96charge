extends Node
class_name ChargeMeterComponent

@export var max_charge_value := 100.0
@export var full_charge_time := 1.5

@onready var timer: Timer = $Timer

var current_charge_value := 0.0 :
	set(val):
		current_charge_value = val
		GameEvents.charge_value_changed.emit()

var player_node: Player

func _ready() -> void:
	player_node = get_tree().get_first_node_in_group("player")
	timer.wait_time = full_charge_time

func get_percent() -> float:
	if max_charge_value <= 0:
		return 0
	return min(current_charge_value / max_charge_value, 1.0)

func _process(delta: float) -> void:
	_dash_input_processing()

func _dash_input_processing() -> void:
	if Input.is_action_pressed("charge") and not player_node._is_dashing():
		current_charge_value = min(current_charge_value + 1, max_charge_value)
	
	if Input.is_action_just_released("charge") and current_charge_value == max_charge_value:
		player_node._dash_input()
		current_charge_value = 0
	
	if not Input.is_action_pressed("charge") and current_charge_value < max_charge_value:
		current_charge_value = max(current_charge_value - 2, 0)

# When chrage is pressed, the charge meter is being 
