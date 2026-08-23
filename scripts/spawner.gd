extends Node2D

@onready var marker_2d: Marker2D = $Marker2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var mimic_tres := preload("uid://cx8vaknv85vdy")
@onready var wall_tres := preload("uid://c6uf0dwi16mrt")

@export var obstacle_scene: PackedScene
@export var fence_scene: PackedScene

@export var score_object_scene: PackedScene


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

func spawn_score_object(_tres: EntityStats) -> void:
	if score_object_scene == null:
		printerr("score_object_scene null")
		return
	
	var score_obj_instance := score_object_scene.instantiate() as ScoreObject
	var entity_group_node := get_tree().get_first_node_in_group(GameConstant.ENTITY_GROUP_STRING)
	score_obj_instance.global_position = marker_2d.global_position
	score_obj_instance.stats = _tres
	entity_group_node.add_child(score_obj_instance)
	
	var base_speed = score_obj_instance.stats.base_speed
	var dash_modifier = score_obj_instance.stats.dash_modifier if _is_dashed else 1
	var resultant_speed = base_speed * dash_modifier
	score_obj_instance.velocity_component.set_max_speed(resultant_speed)

func spawn_fence() -> void:
	spawn_score_object(mimic_tres)

func spawn_obstalce() -> void:
	spawn_score_object(wall_tres)
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	var anims_list_size = animation_player.get_animation_list().size()
	var chosen_anim = animation_player.get_animation_list()[randi_range(0, anims_list_size-1)]
	animation_player.play(chosen_anim)
	
