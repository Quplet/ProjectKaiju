extends CharacterBody2D

@export var speed: float = 50.0
var hitstun: float = 0.0
var moving: bool = false

func in_hitstun() -> bool:
	return hitstun > 0.0

func _physics_process(delta: float):
	if in_hitstun() or !moving:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	move_and_slide()

func _process(delta: float):
	if in_hitstun():
		$StateMachineComponent.running = false
		hitstun = move_toward(hitstun, 0.0, delta * 500.0)
	else:
		$StateMachineComponent.running = true
		
		if !$Body.is_attacking():
			$Body.switch_animation("idle")
	
func _on_health_component_on_death():
	$death_sfx.play(0)
	if ($death_sfx.finished):
		print("audio fin")
		get_tree().queue_delete(self)
	
func flip_body(direction: float):
	$Body.flip_body(direction)
	
func _on_hurtbox_component_hit(attack: Attack):
	hitstun = attack.knockback_force
