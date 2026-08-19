extends CharacterBody2D
## Fence - Needs to be broken by player to score points

@onready var velocity_component: Node = $VelocityComponent

func _ready() -> void:
	velocity_component.accelerate_in_direction(Vector2.LEFT)

func _process(delta: float) -> void:
	velocity_component.move(self)


func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		queue_free()
