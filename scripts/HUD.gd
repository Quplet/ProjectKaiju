extends Node

var menu_stack: Array[String] = []
var logger: Log = Util.LOGGER


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
	push_menu("OptionsMenu")

func _on_back_button_pressed():
	pop_menu()
