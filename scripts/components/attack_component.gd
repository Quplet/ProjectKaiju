extends Area2D
class_name AttackComponent

@export var attack_animation_name: StringName
@export var startup_duration: float
@export var attack_duration: float
@export var endlag_duration: float
@export var attack_damage: float
@export var attack_knockback: float
@export var entity: CharacterBody2D
@export var attack_range_area: Area2D

var attack_sounds: Array[AudioStreamPlayer2D]
var active: bool

var logger: Log = Util.LOGGER

# Called when the node enters the scene tree for the first time.
func _ready():
	if entity == null:
		logger.error("AttackComponent is not attached to an entity!")

	if $Hitbox == null:
		logger.fatal("AttackComponent has no hitbox! Reminder that it is expecting its hitbox child node to be named 'Hitbox'!")

	for child in get_children():
		if child is AudioStreamPlayer2D:
			attack_sounds.append(child)

	self.visible = false
	$Hitbox.set_deferred("disabled", true)

func attack():
	get_parent().switch_animation(attack_animation_name)
	
	active = true
	$StartupDurationTimer.start(startup_duration)

func enable_hitbox():
	for sfx in attack_sounds:
		sfx.play()
		
	self.visible = true
	$Hitbox.set_deferred("disabled", false)

	$AttackDurationTimer.start(attack_duration)
	
func end_attack():
	self.visible = false
	$Hitbox.set_deferred("disabled", true)
	
	$EndlagDurationTimer.start(endlag_duration)

func cancel_attack():
	$StartupDurationTimer.stop()
	$AttackDurationTimer.stop()
	$EndlagDurationTimer.stop()
	
	self.visible = false
	$Hitbox.set_deferred("disabled", true)
	
	active = false

func is_attack_active():
	return active

func _on_area_entered(area):
	if area is HurtboxComponent and area != get_node_or_null("../HurtboxComponent"):
		var hurtbox: HurtboxComponent = area
		if attack_range_area.overlaps_body(hurtbox.entity):
			logger.debug("[" + entity.name + "] Attack with damage: " + str(attack_damage) + ", knockback: " + str(attack_knockback) + ", sent to " + area.get_parent().get_parent().name)
			hurtbox.damage(Attack.new(attack_damage, entity.global_position, attack_knockback))

func _on_startup_duration_timer_timeout():
	enable_hitbox()
	
func _on_attack_duration_timer_timeout():
	end_attack()

func _on_endlag_duration_timer_timeout():
	active = false
