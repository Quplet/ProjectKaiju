extends CharacterBody2D

func flip_body(direction: float):
	if direction == 0.0:
		return

	$AnimatedSprite2D.flip_h = direction < 0
	$ShootAttackComponent.scale.x = direction/abs(direction)
	
func is_attacking():
	$ShootAttackComponent.is_attack_active()

func switch_animation(animation_name: StringName):
	$AnimatedSprite2D.animation = animation_name	
