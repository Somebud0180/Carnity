extends Area2D

var timer
var player

var spawn_point: Vector2i = Vector2i(0, -32)

func _on_body_entered(body: Node2D) -> void:
	player = get_node("../Player")
	
	if body == player and player.is_active:
		await get_tree().create_timer(0.2).timeout
		_on_timer_timeout()


func _on_timer_timeout() -> void:
	player.velocity.x = 0
	player.velocity.y = 0
	player.position = spawn_point
