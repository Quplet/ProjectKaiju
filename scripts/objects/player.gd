extends CharacterBody2D

@export var SPEED_X: float = 200.0
@export var SPEED_Y: float = 75.0
@export var JUMP_VELOCITY = -600.0

var rng = RandomNumberGenerator.new()
var randNum: int = -1
var logger: Log = Util.LOGGER
var player_in_air: bool = false

signal player_landed(hasLanded)
signal player_heavy_signal

func _ready():
	logger.CURRENT_LOG_LEVEL = logger.LogLevel.DEBUG #debug

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	var direction_x: float = Input.get_axis("left", "right")
	var direction_y: float = Input.get_axis("up", "down")
	
	if $Body.is_on_floor():
		if (player_in_air):
			emit_signal("player_landed",player_in_air)
			$floor_sfx/floor_land.play()
			player_in_air = false
		else:
			emit_signal("player_landed",player_in_air)
		
		if (not direction_x) or $Body.is_attacking() or $Body.in_hitstun():
			velocity.x = move_toward(velocity.x, 0, SPEED_X/5.0)
	
		if (not direction_y) or $Body.is_attacking() or $Body.in_hitstun(): 
			velocity.y = move_toward(velocity.y, 0, SPEED_Y/5.0)
		

		if !$Body.is_attacking() and !$Body.in_hitstun():
			if direction_y:
				velocity.y = direction_y * SPEED_Y
				velocity.x = direction_x * SPEED_X/20.0
				$Body.flip_body(direction_x)
				play_ground_sfx()
			
			if direction_x:
				velocity.x = direction_x * SPEED_X
				$Body.flip_body(direction_x)
				play_ground_sfx()
	
			if Input.is_action_just_pressed("jump"):
				$Body.velocity.y = JUMP_VELOCITY
				player_in_air=true
				$JumpSfx.play()
				$JumpRoar.play()

			#if velocity.x == 0 and velocity.y == 0:
			#	$Body.switch_animation("idle")
			$Body.switch_animation("idle")

			if Input.is_action_just_pressed("light_attack"):
				$Body.light_attack()
			if Input.is_action_just_pressed("heavy_attack"):
				$Body.heavy_attack()
				player_heavy_signal.emit()
	else:
		#implement air attacks and animations here if we get to it
		#otherwise for now, it'll just be jump/the in-air animation
		$Body.switch_animation("jump")
		
	move_and_slide()

func play_ground_sfx():
	randNum = randi_range(0,6)
	if (randNum == 0):
		$floor_sfx/floor_metalA.play()
	if (randNum == 1):
		$floor_sfx/floor_metalB.play()
	if (randNum == 2):
		$floor_sfx/floor_stoneA.play()
	if (randNum == 3):
		$floor_sfx/floor_stoneB.play()

func _on_health_component_current_health(player_health):
	emit_signal("player_health",player_health)
	pass # Replace with function body.
