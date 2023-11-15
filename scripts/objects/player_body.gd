extends CharacterBody2D



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()


func switch_animation(animation_name: StringName):
	$AnimatedSprite2D.animation = animation_name

func flip_body(direction: float):
	if direction == 0.0:
		return

	$AnimatedSprite2D.flip_h = direction < 0
	$LightAttackComponent.scale.x = direction/abs(direction)

func light_attack():
	$LightAttackComponent.attack()

func is_attacking() -> bool:
	if $LightAttackComponent.is_attack_active():
		return true
	
	return false