extends Button

@export var level: PackedScene
@onready var menu = get_node("/root/Menu")
@onready var animation_player = %AnimationPlayer

func _on_pressed() -> void:
	menu.level_to_load = level
	menu.load_game()
	animation_player.play("hide_level_picker")
