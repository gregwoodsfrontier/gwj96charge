extends Node2D

@onready var marker_2d: Marker2D = $Marker2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var obstacle_scene: PackedScene
@export var fence_scene: PackedScene

var _is_dashed := false
#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("test"):
		#spawn_fence()

func _ready() -> void:
	animation_player.play("pattern_a")
	GameEvents.player_dash_started.connect(_on_player_dash_start)
	GameEvents.player_dash_ended.connect(_on_player_dash_end)

func _on_player_dash_start() -> void:
	_is_dashed = true

func _on_player_dash_end() -> void:
	_is_dashed = false

func spawn_fence() -> void:
	if fence_scene:
		var fence_instance := fence_scene.instantiate()
		var entity_group_node := get_tree().get_first_node_in_group(GameConstant.ENTITY_GROUP_STRING)
		fence_instance.global_position = marker_2d.global_position
		entity_group_node.add_child(fence_instance)
		var base_speed = fence_instance.base_speed
		var dash_modifier = fence_instance.dash_modifier
		if _is_dashed:
			fence_instance.velocity_component.set_max_speed(base_speed * dash_modifier)
		else:
			fence_instance.velocity_component.set_max_speed(base_speed)

func spawn_obstalce() -> void:
	if obstacle_scene:
		var obstacle_instance := obstacle_scene.instantiate()
		var entity_group_node := get_tree().get_first_node_in_group(GameConstant.ENTITY_GROUP_STRING)
		obstacle_instance.global_position = marker_2d.global_position
		entity_group_node.add_child(obstacle_instance)
		var base_speed = obstacle_instance.base_speed
		var dash_modifier = obstacle_instance.dash_modifier
		if _is_dashed:
			obstacle_instance.velocity_component.set_max_speed(base_speed * dash_modifier)
		else:
			obstacle_instance.velocity_component.set_max_speed(base_speed)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	var anims_list_size = animation_player.get_animation_list().size()
	var chosen_anim = animation_player.get_animation_list()[randi_range(0, anims_list_size-1)]
	animation_player.play(chosen_anim)
	
