extends Label

@onready var player_node = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	if player_node:
		var health_comp = player_node.health_component
		health_comp.health_changed.connect(_on_health_changed)
	update_label(3, 3)

func _on_health_changed() -> void:
	if player_node:
		var health_comp = player_node.health_component
		var current_hp = health_comp.current_health
		var max_hp = health_comp.max_health
		update_label(current_hp, max_hp)

func update_label(_current_health: int, _max_health: int) -> void:
	text = "%d / %d" % [_current_health, _max_health]
