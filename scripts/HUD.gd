extends Node

var menu_stack: Array[String] = []
var logger: Log = Util.LOGGER

var master_bus = AudioServer.get_bus_index("Master")
var music_bus = AudioServer.get_bus_index("Music")
var sfx_bus = AudioServer.get_bus_index("SFX")


# Called when the node enters the scene tree for the first time.
func _ready():
	logger.info("Initializing menu to MainMenu")
	menu_stack.push_front("MainMenu")


func switch_to_menu(menu: String):
	var children: Array = get_children()
	
	for child in children:
		child.visible = false
		
	get_node(menu).visible = true
	
func push_menu(menu: String):
	var prev_menu = menu_stack[0]
	if prev_menu == null:
		logger.warn("Menu stack base is empty, be careful popping this menu!")
		prev_menu = "none"
	
	logger.info("Going from menu " + prev_menu + " to " + menu + " (pushed)")
	
	menu_stack.push_front(menu)
	switch_to_menu(menu)
	
func pop_menu():
	if menu_stack[1] == null:
		logger.error("No menu to pop back to!")
		return
	
	logger.info("Going from menu " + menu_stack[0] + " to " + menu_stack[1] + " (popped)")
	menu_stack.pop_front()
	switch_to_menu(menu_stack[0])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_options_button_pressed():
	$OptionsMenu/ui_confirm.play(0)
	push_menu("OptionsMenu")

func _on_back_button_pressed():
	$OptionsMenu/ui_cancel.play(0)
	pop_menu()

func _on_play_button_pressed():
	$OptionsMenu/ui_confirm.play(0)
	get_tree().change_scene_to_file("res://scenes/test_scene.tscn")
	pass # Replace with function body.

func _on_h_slider_music_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus,value)
	if value <= -30:
		AudioServer.set_bus_mute(music_bus,true)
	else:
		AudioServer.set_bus_mute(music_bus,false)
	pass # Replace with function body.	pass # Replace with function body.


func _on_h_slider_master_volume_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus,value)
	if value <= -30:
		AudioServer.set_bus_mute(master_bus,true)
	else:
		AudioServer.set_bus_mute(master_bus,false)
	pass # Replace with function body.


func _on_h_slider_sfx_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_bus,value)
	if value <= -30:
		AudioServer.set_bus_mute(sfx_bus,true)
	else:
		AudioServer.set_bus_mute(sfx_bus,false)
	$OptionsMenu/cat.play(0)
	pass # Replace with function body.	pass # Replace with function body.
