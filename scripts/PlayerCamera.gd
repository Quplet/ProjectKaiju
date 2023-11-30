extends Camera2D

@export var random_strength: float = 30.0
@export var shake_fade: float = 5.0

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0
var do_shake: bool = false
var in_shake: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func apply_shake():
	shake_strength = random_strength

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (do_shake && !in_shake):
		apply_shake()
		in_shake = true
	
	if (in_shake):
		if (shake_strength <= 0.1):
			shake_strength=0
			in_shake=false
		if shake_strength > 0:
			shake_strength = lerpf(shake_strength,0,shake_fade*delta)
	offset = random_offset()
	pass
	
func random_offset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength,shake_strength),rng.randf_range(-shake_strength,shake_strength))

func _on_player_player_landed(hasLanded):
	if (hasLanded):
		do_shake=true
	else:
		do_shake=false
	pass # Replace with function body.

func _on_player_player_heavy_signal():
	do_shake=true
	pass # Replace with function body.

func _on_boss_did_heavy():
	do_shake=true
	pass # Replace with function body.
