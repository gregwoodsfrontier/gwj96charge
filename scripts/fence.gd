extends CharacterBody2D
## Fence - Needs to be broken by player to score points
@export var base_speed: int = 200
@export var dash_modifier: float = 1.5

@onready var velocity_component: Node = $VelocityComponent


func _ready() -> void:
	GameEvents.player_dash_started.connect(_on_player_dash_start)
	GameEvents.player_dash_ended.connect(_on_player_dash_end)
	velocity_component.accelerate_in_direction(Vector2.LEFT)

func _process(delta: float) -> void:
	velocity_component.move(self)


func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		queue_free()

func _on_player_dash_start() -> void:
	velocity_component.set_max_speed(base_speed * dash_modifier)
	velocity_component.accelerate_in_direction(Vector2.LEFT)


func _on_player_dash_end() -> void:
	velocity_component.set_max_speed(base_speed)
	velocity_component.accelerate_in_direction(Vector2.LEFT)
