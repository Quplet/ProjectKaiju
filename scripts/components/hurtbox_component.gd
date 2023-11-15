extends Node
class_name HurtboxComponent

@export var health_component : HealthComponent
@export var knockback_component : KnockbackComponent

func damage(attack: Attack):
	if health_component:
		health_component.damage(attack)
	
	if knockback_component:
		knockback_component.knockback(attack)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
