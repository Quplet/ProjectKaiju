extends CharacterBody2D

@export var SPEED_X: float = 200.0
@export var SPEED_Y: float = 75.0

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	var direction_x: float = Input.get_axis("Left", "Right")
	var direction_y: float = Input.get_axis("Up", "Down")
	if direction_x:
		velocity.x = direction_x * SPEED_X
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED_X)

	if direction_y:
		velocity.y = direction_y * SPEED_Y
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED_Y)

	move_and_slide()
