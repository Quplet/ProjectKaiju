extends CharacterBody2D

var lightDir: float = 1.0

func flip_body(direction: float):
	if direction == 0.0:
		return
	
	#3am coding is uh, questionable.
	if (direction < 0):
		lightDir=-1
	else:
		lightDir=1
	
	$AnimatedSprite2D.flip_h = direction < 0
	$HeavyAttackComponent.scale.x = direction/abs(direction)

func switch_animation(animation_name: StringName):
	if animation_name != "idle":
		if animation_name == "hit":
			$pointlight_eye.set_position(Vector2(lightDir*-10, -81))

		if animation_name == "heavy_attack":
			$pointlight_eye.set_position(Vector2(lightDir*27, -71))
	else:
		$pointlight_eye.set_position(Vector2(lightDir*110, -54))
		
	$AnimatedSprite2D.animation = animation_name
	
func is_attacking():
	return $HeavyAttackComponent.is_attack_active()
