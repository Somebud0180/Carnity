extends Button

@export var current_menu: String
@onready var animation_player = %AnimationPlayer
@onready var menu = get_node("/root/Menu")

func _on_pressed() -> void:
	menu._hide_and_show(current_menu, "main")
