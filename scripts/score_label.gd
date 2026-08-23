extends Label

func _ready() -> void:
	GameEvents.score_updated.connect(_on_score_updated)

func _on_score_updated(_new_score: int) -> void:
	var result = "Score:  " + str(_new_score)
	text = result
