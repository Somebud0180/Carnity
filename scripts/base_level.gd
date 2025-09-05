extends Node2D

@onready var player = $Player
@onready var raycast = $SpawnPoint
@onready var killzone = $Killzone
var initialized: bool = false
var spawn_point: Vector2i

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !raycast.is_colliding() or initialized:
		return
	
	spawn_point = raycast.get_collision_point()
	spawn_point = Vector2i(spawn_point.x, spawn_point.y + 12)
	killzone.spawn_point = spawn_point
	
	player.position = spawn_point
	player.is_active = true
	initialized = true
