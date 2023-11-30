extends State
class_name EnemyPersueState

@export var entity: CharacterBody2D
@export var attack_range_area: Area2D
var player: CharacterBody2D

func enter():
	player = get_tree().get_first_node_in_group("Player")
	entity.moving = true
	
func exit():
	entity.moving = false
	
func update(delta: float):
	pass
	
func physics_update(delta: float):
	if not player:
		transitioned.emit(self, "EnemyIdle")
		return
	
	var direction: Vector2 = player.global_position - entity.global_position
	
	entity.flip_body(direction.x)
	
	if attack_range_area.overlaps_body(player):
		transitioned.emit(self, "ShootAttackState")
	else:
		entity.velocity = direction.normalized() * entity.speed
