extends Control

@onready var animation_player = %AnimationPlayer
var level_to_load: PackedScene
var game_scene_path = "res://scenes/game.tscn"

enum STATE { MAIN, LEVELPICKER, GAME }
var menu_state = STATE.MAIN
var in_game: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and !animation_player.is_playing():
		match menu_state:
			STATE.MAIN:
				if in_game:
					animation_player.play("hide_main_invisible")
					menu_state = STATE.GAME
			STATE.LEVELPICKER:
				_hide_and_show("level_picker", "main")
				menu_state = STATE.MAIN
			STATE.GAME:
				animation_player.play("show_main_invisible")
				menu_state = STATE.MAIN

func load_game():
	in_game = true
	menu_state = STATE.GAME
	LoadingManager.load_scene(game_scene_path)
	await animation_player.animation_finished
	animation_player.play("hide_main_invisible")

func _hide_and_show(first: String, second: String):
	animation_player.play("hide_" + first)
	await animation_player.animation_finished
	animation_player.play("show_" + second)
