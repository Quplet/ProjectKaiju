extends Node
class_name HurtboxComponent

@export var health_component: HealthComponent
@export var knockback_component: KnockbackComponent
@export var entity: CharacterBody2D

signal hit(attack: Attack)

var hit_sounds: Array[AudioStreamPlayer2D]

var logger: Log = Util.LOGGER

func damage(attack: Attack):
	logger.debug("[" + entity.name + "] Attack received with damage: " + str(attack.damage) + ", knockback: " + str(attack.knockback_force) + " from: " + str(attack.attack_position))

	for sfx in hit_sounds:
		sfx.play()

	if health_component:
		health_component.damage(attack)
	
	if knockback_component:
		knockback_component.knockback(attack)
	
	hit.emit(attack)

# Called when the node enters the scene tree for the first time.
func _ready():
	if entity == null:
		logger.error("HurtboxComponent is not attached to an entity!")
		
	for child in get_children():
		if child is AudioStreamPlayer2D:
			hit_sounds.append(child)
