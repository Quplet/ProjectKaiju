extends CharacterBody2D

@export var SPEED_X: float = 200.0
@export var SPEED_Y: float = 75.0
@export var JUMP_VELOCITY = -600.0

enum State {
	ATTACKING,
	BLOCKING,
	IDLE
}

var state: State = State.IDLE

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	var direction_x: float = Input.get_axis("left", "right")
	var direction_y: float = Input.get_axis("up", "down")
	
	if $Body.is_on_floor():

		if not direction_x or $Body.is_attacking():
			velocity.x = move_toward(velocity.x, 0, SPEED_X)
	
		if not direction_y or $Body.is_attacking():
			velocity.y = move_toward(velocity.y, 0, SPEED_Y)

		if not $Body.is_attacking():
			if direction_x:
				velocity.x = direction_x * SPEED_X
				$Body.flip_body(direction_x)
		
			if direction_y:
				velocity.y = direction_y * SPEED_Y
	
			if Input.is_action_just_pressed("jump"):
				$Body.velocity.y = JUMP_VELOCITY
				$Body.switch_animation("jump")
	
			#if velocity.x == 0 and velocity.y == 0:
			#	$Body.switch_animation("idle")
			$Body.switch_animation("idle")

			if Input.is_action_just_pressed("light_attack"):
				$Body.light_attack()
			if Input.is_action_just_pressed("heavy_attack"):
				$Body.heavy_attack()

	move_and_slide()
