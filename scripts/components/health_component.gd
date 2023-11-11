extends Node
class_name HealthComponent

@export var MAX_HEALTH: float = 100.0
var health: float

func damage(attack: Attack):
	health -= attack.damage

# Called when the node enters the scene tree for the first time.
func _ready():
	health = MAX_HEALTH


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
