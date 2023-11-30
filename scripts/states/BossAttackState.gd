extends State
class_name BossAttackState

@export var entity: CharacterBody2D
@export var attack_range_area: Area2D
@export var attack_component: AttackComponent
@export var attack_distance: float
var player: CharacterBody2D
var wait_time: float

func enter():
	player = get_tree().get_first_node_in_group("Player")
	wait_time = 0.1
	
func exit():
	pass
	
func update(delta: float):
	if attack_component.is_attack_active():
		return
		
	if !player:
		transitioned.emit(self, "BossIdleState")
		return
		
	var distance: float = (player.global_position - entity.global_position).length()
		
	if !attack_range_area.overlaps_body(player) or distance > attack_distance:
		transitioned.emit(self, "BossPersueState")
		return
	
	if wait_time > 0.0:
		wait_time = move_toward(wait_time, 0.0, delta)
		return
		
	attack_component.attack()
	wait_time = 0.75
	
func physics_update(delta: float):
	pass
