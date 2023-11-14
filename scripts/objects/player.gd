extends CharacterBody2D

@export var SPEED_X: float = 200.0
@export var SPEED_Y: float = 75.0
@export var JUMP_VELOCITY = -600.0

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	var direction_x: float = Input.get_axis("left", "right")
	var direction_y: float = Input.get_axis("up", "down")
	
	if $Body.is_on_floor():
		if direction_x:
			velocity.x = direction_x * SPEED_X

			$Body.flip_body(direction_x)

		else:
			velocity.x = move_toward(velocity.x, 0, SPEED_X)
	
		if direction_y:
			velocity.y = direction_y * SPEED_Y
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED_Y)

		if velocity.x == 0 and velocity.y == 0:
			$Body.switch_animation("idle")

	move_and_slide()
