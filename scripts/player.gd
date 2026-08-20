extends CharacterBody2D

enum PLAYER_STATE {
	DEFAULT = 0,
	CHARGING = 1,
	CHARGED = 2,
	DASHING = 4 
}

# code for charging meter
var current_charge_meter_value: float = 0.0 :
	set(value):
		current_charge_meter_value = value
		GameEvents.charge_value_changed.emit(value)
var dash_timer: float = 0.0
var state_bitflag = 0

@export var velocity_component: Node
@export var gravity := Vector2(0, 0)

func _is_charging() -> bool:
	return state_bitflag & PLAYER_STATE.CHARGING != 0

func _is_charged() -> bool:
	return state_bitflag & PLAYER_STATE.CHARGED != 0

func _is_dashing() -> bool:
	return state_bitflag & PLAYER_STATE.DASHING != 0

func _check_valid(_node: Node, _method_string: StringName) -> bool:
	return _node != null and _node.has_method(_method_string)


func _process(delta: float) -> void:
	_jump_input()
	_dash_input()
	
	velocity_component.velocity += gravity * get_process_delta_time()

func _physics_process(delta: float) -> void:
	if _check_valid(velocity_component, "move"):
	#if velocity_component and velocity_component.has_method("move"):
		velocity_component.move(self)
	

func _jump_input() -> void:
	if Input.is_action_pressed("jump") and is_on_floor():
		if _check_valid(velocity_component, "accelerate_in_direction"):
			velocity_component.accelerate_in_direction(Vector2.UP)


# TODO: Code for dashing and break obstacle. The player should not move from x but all the other 
# entities and bg should be faster.
func _dash_input() -> void:
	if Input.is_action_pressed("charge") and not _is_dashing():
		state_bitflag = PLAYER_STATE.DASHING
		dash_timer = GameConstant.PLAYER.DASH_TIME
		GameEvents.player_dash_started.emit()
		print("player dash start")
		#velocity_component.accelerate_in_direction(Vector2.RIGHT, GameConstant.PLAYER.DASH_SPEED)
	
	if dash_timer > 0.0:
		dash_timer = max(0.0, dash_timer - get_process_delta_time())
	 
	if dash_timer <= 0.0 and _is_dashing():
		state_bitflag = PLAYER_STATE.DEFAULT
		GameEvents.player_dash_ended.emit()
		print("player dash ended")

# TODO: Code for player charging to dash
