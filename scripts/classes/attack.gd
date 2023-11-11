class_name Attack

var damage : float
var attack_position: Vector2
var knockback_force : float

func _init(damage_value : float, position_value : Vector2, knockback_value : float = 0.0):
	damage = damage_value
	attack_position = position_value
	knockback_force = knockback_value
