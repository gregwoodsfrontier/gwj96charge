extends Node2D

@onready var marker_2d: Marker2D = $Marker2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var obstacle_scene: PackedScene
@export var fence_scene: PackedScene

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("test"):
		#spawn_fence()

func _ready() -> void:
	animation_player.play("pattern_a")

func spawn_fence() -> void:
	if fence_scene:
		var fence_instance := fence_scene.instantiate()
		var entity_group_node := get_tree().get_first_node_in_group(GameConstant.ENTITY_GROUP_STRING)
		fence_instance.global_position = marker_2d.global_position
		entity_group_node.add_child(fence_instance)

func spawn_obstalce() -> void:
	if obstacle_scene:
		var obstacle_instance := obstacle_scene.instantiate()
		var entity_group_node := get_tree().get_first_node_in_group(GameConstant.ENTITY_GROUP_STRING)
		obstacle_instance.global_position = marker_2d.global_position
		entity_group_node.add_child(obstacle_instance)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	var anims_list_size = animation_player.get_animation_list().size()
	var chosen_anim = animation_player.get_animation_list()[randi_range(0, anims_list_size-1)]
	animation_player.play(chosen_anim)
	
