extends CharacterBody2D
class_name ScoreObject

@export var stats : EntityStats

@onready var velocity_component: Node = $VelocityComponent
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	GameEvents.player_dash_started.connect(_on_player_dash_start)
	GameEvents.player_dash_ended.connect(_on_player_dash_end)
	sprite_2d.texture = stats.texture
	velocity_component.accelerate_in_direction(Vector2.LEFT)

func _process(delta: float) -> void:
	velocity_component.move(self)

func _on_player_detection_body_entered(body: Node2D) -> void:
	var player  = body
	var health = player.get_health_component()
	if body.is_in_group("player"):
		if stats.is_breakable == false:
			if health != null:
				health.damage(1)
			
			queue_free()
			return
		
		if player._is_dashing():
			GameEvents.score_received.emit(stats.score)
		else:
			if health != null:
				health.damage(1)
		queue_free()

func _on_player_dash_start() -> void:
	var base_speed := stats.base_speed
	var dash_modifier := stats.dash_modifier
	velocity_component.set_max_speed(base_speed * dash_modifier)
	velocity_component.accelerate_in_direction(Vector2.LEFT)


func _on_player_dash_end() -> void:
	var base_speed := stats.base_speed
	var dash_modifier := stats.dash_modifier
	velocity_component.set_max_speed(base_speed)
	velocity_component.accelerate_in_direction(Vector2.LEFT)
