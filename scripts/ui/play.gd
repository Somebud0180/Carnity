extends Button

@onready var animation_player = %AnimationPlayer
@onready var menu = get_node("/root/Menu")

func _on_pressed() -> void:
	menu._hide_and_show("main", "level_picker")
	menu.menu_state =  menu.STATE.LEVELPICKER
