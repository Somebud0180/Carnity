extends Area2D

var timer
var player

func _on_body_entered(body: Node2D) -> void:
	player = get_node("../../Player")
	
	if body == player:
		await get_tree().create_timer(0.2).timeout
		_on_timer_timeout()


func _on_timer_timeout() -> void:
	player.velocity.x = 0
	player.velocity.y = 0
	player.position = Vector2i(0,-32)
