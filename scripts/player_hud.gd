extends CanvasLayer

var player_node

# Called when the node enters the scene tree for the first time.
func _ready():
	player_node=get_parent().get_parent()
	$health_bar.max_value=player_node.get_node("Body/HealthComponent").MAX_HEALTH
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$health_bar.value=player_node.get_node("Body/HealthComponent").health
	pass
