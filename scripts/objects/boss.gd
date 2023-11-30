extends CharacterBody2D

@export var speed: float = 100.0
var hitstun: float = 0.0
var moving: bool = false

signal did_heavy

func in_hitstun() -> bool:
	return hitstun > 0.0
	
func _physics_process(delta: float):
	if in_hitstun() or !moving:
		velocity.x = move_toward(velocity.x, 0, speed/10.0)
		velocity.y = move_toward(velocity.y, 0, speed/10.0)
	move_and_slide()

func _process(delta: float):
	if in_hitstun():
		$StateMachineComponent.running = false
		hitstun = move_toward(hitstun, 0.0, delta * 750.0)
		$Body.switch_animation("hit")
	else:
		$StateMachineComponent.running = true
		
		if !$Body.is_attacking():
			$Body.switch_animation("idle")
		else:
			did_heavy.emit()

func _on_health_component_on_death():
	get_tree().queue_delete(self)
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
func flip_body(direction: float):
	$Body.flip_body(direction)
	
func _on_hurtbox_component_hit(attack: Attack):
	if !$Body.is_attacking():
		hitstun = attack.knockback_force
