extends Node
class_name KnockbackComponent

var entity: CharacterBody2D
var logger: Log = Util.LOGGER

@export var knockback_resistance: float = 0.0

func knockback(attack: Attack):
	logger.debug("[" + entity.name + "] recieved knockback of value: " + str(attack.knockback_force) + ", from " + str(attack.attack_position))

	var net_force = attack.knockback_force * (1 - knockback_resistance)

	var light_attack_component: AttackComponent = get_node_or_null("../LightAttackComponent")
	if net_force > 20 and light_attack_component != null and light_attack_component.is_attack_active():
		light_attack_component.end_attack()

	var heavy_attack_component: AttackComponent = get_node_or_null("../HeavyAttackComponent")
	if net_force > 30 and heavy_attack_component != null and heavy_attack_component.is_attack_active():
		heavy_attack_component.end_attack()

	entity.velocity += (entity.global_position - attack.attack_position).normalized() * net_force


# Called when the node enters the scene tree for the first time.
func _ready():
	knockback_resistance = clamp(knockback_resistance, 0.0, 1.0)

	entity = get_parent().get_parent() 
	if not entity:
		logger.error("KnockbackComponent has no entity!")
		return

	if entity.get("velocity") == null:
		logger.error("KnockbackComponent entity has no velecity property! Parent: " + entity.name)
		return
