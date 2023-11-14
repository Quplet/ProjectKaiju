extends CharacterBody2D



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = get_parent().JUMP_VELOCITY
		$AnimatedSprite2D.animation = "jump"

	move_and_slide()


func switch_animation(animation_name: StringName):
	$AnimatedSprite2D.animation = animation_name

func flip_body(direction: int):
	$AnimatedSprite2D.flip_h = direction < 0