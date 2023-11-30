extends State
class_name BossPersueState

@export var entity: CharacterBody2D
@export var attack_range_area: Area2D
@export var attack_distance: float
var player: CharacterBody2D

func enter():
	player = get_tree().get_first_node_in_group("Player")
	entity.moving = true
	
func exit():
	entity.moving = false
	
func update(delta: float):
	pass
	
func physics_update(delta: float):
	if !player:
		transitioned.emit(self, "BossIdleState")
		return
		
	var direction: Vector2 = player.global_position - entity.global_position
	
	entity.flip_body(direction.x)
	
	if direction.length() < attack_distance and attack_range_area.overlaps_body(player):
		transitioned.emit(self, "BossAttackState")
	else:
		entity.velocity = direction.normalized() * entity.speed
