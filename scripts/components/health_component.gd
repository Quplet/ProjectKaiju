extends Node
class_name HealthComponent

@export var MAX_HEALTH: float = 100.0
@export var sprite: CanvasItem

signal on_death
signal current_health(player_health)

var red_shift: float = 0.0
var red_shift_decrease_rate: float = 1.0
@export var health: float

func damage(attack: Attack):
	health -= attack.damage
	
	if attack.damage > 0.0:
		red_shift = 1.0
		red_shift_decrease_rate = max(2.0 - attack.damage / 40.0, 0.1)
		
	if health <= 0.0:
		on_death.emit()
	emit_signal("current_health",health)

# Called when the node enters the scene tree for the first time.
func _ready():
	health = MAX_HEALTH
	
func _process(delta: float):
	if red_shift > 0.0:
		red_shift = max(red_shift - red_shift_decrease_rate * delta, 0.0)
		sprite.material.set_shader_parameter("red_shift_ammount", red_shift)
	
