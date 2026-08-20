extends Node

@export var max_speed : int = 40
@export var acceleration : float = 5.0

var velocity := Vector2.ZERO

func set_max_speed(_val: int) -> void:
	max_speed = _val


func accelerate_in_direction(direction:Vector2, _speed: int = max_speed):
	var desired_velocity := direction * _speed
	velocity = velocity.lerp(desired_velocity, 1 - exp(-acceleration * get_process_delta_time()))


func decelerate():
	accelerate_in_direction(Vector2.ZERO)


func move(character_body: CharacterBody2D):
	character_body.velocity = velocity
	character_body.move_and_slide()
	velocity = character_body.velocity

func move_node2d(_node2d: Node2D):
	_node2d.position += velocity * get_process_delta_time()
