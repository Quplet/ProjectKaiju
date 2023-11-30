extends State
class_name BossIdleState

@export var entity: CharacterBody2D
@export var visibility: float
var player: CharacterBody2D

func enter():
	player = get_tree().get_first_node_in_group("Player")
	
func exit():
	pass
	
func update(delta: float):
	pass
	
func physics_update(delta: float):
	if not player:
		return
		
	var distance = (player.global_position - entity.global_position).length()
	
	if distance < visibility:
		transitioned.emit(self, "BossPersueState")
