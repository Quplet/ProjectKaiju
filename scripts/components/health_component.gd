extends Node
class_name HealthComponent

@export var MAX_HEALTH: float = 100.0
@export var sprite: CanvasItem

var red_shift: float = 0.0
var red_shift_decrease_rate = 1.0
var health: float

func damage(attack: Attack):
	health -= attack.damage
	
	if attack.damage > 0.0:
		red_shift = 1.0
		red_shift_decrease_rate = max(2.0 - attack.damage / 40.0, 0.1)

# Called when the node enters the scene tree for the first time.
func _ready():
	health = MAX_HEALTH
	
func _process(delta: float):
	if red_shift > 0.0:
		red_shift = max(red_shift - red_shift_decrease_rate * delta, 0.0)
		sprite.material.set_shader_parameter("red_shift_ammount", red_shift)
	

