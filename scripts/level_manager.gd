extends Node2D

signal finished_loading

# A level loader
func load_level(scene: PackedScene):
	var loaded_scene = scene.instantiate()
	add_sibling(loaded_scene)
	
	await get_tree().process_frame
	emit_signal("finished_loading")
