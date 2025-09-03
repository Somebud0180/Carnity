extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite.stop()
		if velocity.x > 0:
			animated_sprite.frame = 1
		elif velocity.x < 0:
			animated_sprite.frame = 0

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		if velocity.x > 0:
			animated_sprite.animation = "walk_right"
		elif velocity.x < 0:
			animated_sprite.animation = "walk_left"
		
		if !animated_sprite.is_playing():
			animated_sprite.play()
		
		velocity.x = direction * SPEED
	else:
		animated_sprite.stop()
		
		if velocity.x > 0:
			$AnimatedSprite2D.frame = 1
		elif velocity.x < 0:
			$AnimatedSprite2D.frame = 0
		
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
