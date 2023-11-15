extends Node
class_name HurtboxComponent

@export var health_component: HealthComponent
@export var knockback_component: KnockbackComponent
@export var hit_sounds: Array[AudioStreamPlayer2D]

var entity: Node
var logger: Log = Util.LOGGER

func damage(attack: Attack):
	logger.debug("[" + entity.name + "] Attack received with damage: " + str(attack.damage) + ", knockback: " + str(attack.knockback_force) + " from: " + str(attack.attack_position))

	for sfx in hit_sounds:
		sfx.play()

	if health_component:
		health_component.damage(attack)
	
	if knockback_component:
		knockback_component.knockback(attack)

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent() == null:
		logger.error("HurtboxComponent has no parent!")
	
	entity = get_parent().get_parent()

	if entity == null:
		logger.error("HurtboxComponent found Body, but didn't find parent entity!")
