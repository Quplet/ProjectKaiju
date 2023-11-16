extends CharacterBody2D


@export var speed_x: float = 200.0
@export var speed_y: float = 50.0

func _physics_process(delta):
	velocity.x = move_toward(velocity.x, 0, 30)
	velocity.y = move_toward(velocity.y, 0, 30)
	move_and_slide()
