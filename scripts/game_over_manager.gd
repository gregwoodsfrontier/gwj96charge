extends Node

@onready var game_over_screen: CanvasLayer = $"../GameOverScreen"
@onready var game_over_label: Label = $"../GameOverScreen/MarginContainer/GameOverLabel"
@onready var restart_timer: Timer = $"../GameOverScreen/RestartTimer"

func _ready() -> void:
	game_over_screen.hide()
	var player_node := get_tree().get_first_node_in_group(GameConstant.PLAYER_STRING) as Player
	await player_node.ready
	var health_comp := player_node.get_health_component()
	if health_comp:
		health_comp.death.connect(_on_player_death)
	
	restart_timer.timeout.connect(_on_restart_timer_timeout)

func _on_restart_timer_timeout() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_player_death() -> void:
	get_tree().paused = true
	game_over_label.text = GameConstant.GAME_LOSE_TEXT
	game_over_screen.show()
	restart_timer.start()
