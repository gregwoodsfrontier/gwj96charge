extends Node
class_name ScoreManager

var score := 0 :
	set(val):
		score = val
		GameEvents.score_updated.emit(score)

func _ready() -> void:
	GameEvents.score_received.connect(_on_score_received)

func _on_score_received(_val: int) -> void:
	gain_score(_val)

func gain_score(_val: int) -> void:
	score += _val
