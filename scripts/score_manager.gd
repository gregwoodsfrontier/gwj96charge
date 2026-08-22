extends Node
class_name ScoreManager

var score := 0 :
	set(val):
		score = val
		GameEvents.score_updated.emit(score)

func gain_score(_val: int) -> void:
	score += _val
