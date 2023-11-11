class_name Attack

var damage : float
var attack_position: Vector2
var knockback_force : float


static func create(damage_value : float, position_value : Vector2, knockback_value : float = 0.0) -> Attack:
	var attack : Attack = Attack.new()
	attack.damage = damage_value
	attack.attack_position = position_value
	attack.knockback_force = knockback_value
	return attack
