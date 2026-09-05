extends Node2D
class_name DeathComponent

#@export var health_component: HealthComponent
@export var sprite: Sprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready():
	if gpu_particles_2d != null:
		if get_parent() is ScoreObject:
			gpu_particles_2d.texture = get_parent().stats.texture
	#health_component.death.connect(_on_death)

func _on_death():
	if owner == null || not owner is Node2D:
		return
		
	var spawn_position = owner.global_position
	var tree = get_tree()
	var entities = tree.get_first_node_in_group(GameConstant.ENTITY_GROUP_STRING)
	
	get_parent().remove_child(self)
	entities.add_child(self)
	
	global_position = spawn_position
	animation_player.play("default")
	
