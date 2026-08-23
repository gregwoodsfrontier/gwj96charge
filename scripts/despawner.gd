extends Area2D


func _on_body_entered(body: Node2D) -> void:
	var stats = body.stats
	if stats == null:
		return
	if not stats is EntityStats:
		return
	if !stats.is_breakable:
		GameEvents.score_received.emit(stats.score)
