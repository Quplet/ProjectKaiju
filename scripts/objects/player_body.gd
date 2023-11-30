extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var hitstun: float = 0.0

func _physics_process(delta: float):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()

func _process(delta: float):
	hitstun = move_toward(hitstun, 0.0, delta * 750)
	
	if hitstun > 0:
		switch_animation("hit")

func switch_animation(animation_name: StringName):
	$AnimatedSprite2D.animation = animation_name

func flip_body(direction: float):
	if direction == 0.0:
		return

	$AnimatedSprite2D.flip_h = direction < 0
	$LightAttackComponent.scale.x = direction/abs(direction)
	$HeavyAttackComponent.scale.x = direction/abs(direction)

func light_attack():
	$LightAttackComponent.attack()

func heavy_attack():
	$HeavyAttackComponent.attack()

func is_attacking() -> bool:
	if $LightAttackComponent.is_attack_active():
		return true

	if $HeavyAttackComponent.is_attack_active():
		return true
	
	return false
	
func in_hitstun() -> bool:
	return hitstun > 0.0

func _on_hurtbox_component_hit(attack: Attack):
	if !is_attacking():
		hitstun = attack.knockback_force
