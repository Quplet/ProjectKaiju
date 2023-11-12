extends Node
class_name KnockbackComponent

var logger: Log = Util.LOGGER

@export var knockback_resistance: float = 0.0

func knockback(attack: Attack):
	# All components will be attached to a characterbody attached to a characterbody. We want the knockback to affect the root body.
	var parent = get_parent().get_parent() 
	if not parent:
		logger.error("KnockbackComponent has no parent!")
		return

	if not parent.get("velocity"):
		logger.error("KnockbackComponent parent has no velecity property! Parent: " + parent.name)
		return

	parent.velocity += (parent.global_position - attack.attack_position).normalized() * (attack.knockback_force * (1 - knockback_resistance))


# Called when the node enters the scene tree for the first time.
func _ready():
	knockback_resistance = clamp(knockback_resistance, 0.0, 1.0)
