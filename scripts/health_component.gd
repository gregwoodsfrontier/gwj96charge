extends Node
class_name HealthComponent

signal death
signal health_changed

@export var max_health: int = 3
var current_health: int

func _ready():
	current_health = max_health

func damage(amount: float):
	current_health = max(current_health - amount, 0)
	health_changed.emit()
	Callable(check_health).call_deferred()


# Only player has health. If zero, the game is over.
func check_health():
	if current_health == 0:
		death.emit()
