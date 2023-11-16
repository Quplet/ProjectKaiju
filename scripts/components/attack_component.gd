extends Area2D
class_name AttackComponent

@export var attack_animation_name: StringName
@export var attack_duration: float
@export var attack_damage: float
@export var attack_knockback: float
@export var entity: CharacterBody2D

var attack_sounds: Array[AudioStreamPlayer2D]

var logger: Log = Util.LOGGER

signal attack_start
signal attack_end

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
	attack_start.emit()

	get_parent().switch_animation(attack_animation_name)

	for sfx in attack_sounds:
		sfx.play()

	self.visible = true
	$Hitbox.set_deferred("disabled", false)

	$DurationTimer.start(attack_duration)

func end_attack():
	attack_end.emit()
	$DurationTimer.stop()

	self.visible = false
	$Hitbox.set_deferred("disabled", true)

func is_attack_active():
	return not $DurationTimer.is_stopped()

func _on_duration_timer_timeout():
	end_attack()

func _on_area_entered(area):
	if area is HurtboxComponent and area != get_node_or_null("../HurtboxComponent"):
		var hurtbox: HurtboxComponent = area

		logger.debug("[" + entity.name + "] Attack with damage: " + str(attack_damage) + ", knockback: " + str(attack_knockback) + ", sent to " + area.get_parent().get_parent().name)
		hurtbox.damage(Attack.new(attack_damage, entity.global_position, attack_knockback))

	



