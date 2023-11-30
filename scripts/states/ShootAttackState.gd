extends State
class_name ShootAttackState

@export var entity: CharacterBody2D
@export var attack_range_area: Area2D
@export var attack_component: AttackComponent
var wait_time: float
var player: CharacterBody2D


func enter():
	player = get_tree().get_first_node_in_group("Player")
	wait_time = 0.5
	
func exit():
	pass
	
func update(delta: float):
	if attack_component.is_attack_active():
		return
	
	if not player:
		transitioned.emit(self, "EnemyIdle")
		return
	
	if !attack_range_area.overlaps_body(player):
		transitioned.emit(self, "EnemyPersueState")
		return
	
	if wait_time > 0.0:
		wait_time = move_toward(wait_time, 0.0, delta)
		return
		
	attack_component.attack()
	wait_time = 0.5
	
func physics_update(delta: float):
	pass
