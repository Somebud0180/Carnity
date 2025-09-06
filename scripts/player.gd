extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var progress_bar = $ProgressBar
var is_active: bool = false

const SPEED = 200.0
const JUMP_VELOCITY = -350.0

func _ready() -> void:
	add_to_group("Players")

func _physics_process(delta: float) -> void:
	if is_active:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta
			if animated_sprite.animation == "walk_right" or animated_sprite.animation == "stand" and animated_sprite.frame == 1:
				animated_sprite.animation = "leap"
				animated_sprite.frame = 1
			elif animated_sprite.animation == "walk_left" or animated_sprite.animation == "stand" and animated_sprite.frame == 0:
				animated_sprite.animation = "leap"
				animated_sprite.frame = 0

		# Handle jump.
		if Input.is_action_pressed("action_one") and is_on_floor():
			progress_bar.visible = true
			progress_bar.value += 0.33
		else:
			progress_bar.visible = false
			progress_bar.value -= 1
		
		if Input.is_action_just_pressed("jump") and is_on_floor():
			if progress_bar.value == progress_bar.max_value:
				velocity.y = JUMP_VELOCITY * 1.5
				progress_bar.visible = false
				progress_bar.value = 0
			elif progress_bar.value >= progress_bar.max_value / 2:
				velocity.y = JUMP_VELOCITY * 1.25
				progress_bar.visible = false
				progress_bar.value = 0
			else:
				velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("move_left", "move_right")
		if direction:
			if is_on_floor():
				if velocity.x > 0:
					animated_sprite.animation = "walk_right"
				elif velocity.x < 0:
					animated_sprite.animation = "walk_left"
			
			if !animated_sprite.is_playing():
				animated_sprite.play()
			
			velocity.x = direction * SPEED
		else:
			if velocity.x == 0:
				if is_on_floor():
					if animated_sprite.animation == "walk_right" or animated_sprite.animation == "leap" and animated_sprite.frame == 1:
						animated_sprite.animation = "stand"
						$AnimatedSprite2D.frame = 1
					elif animated_sprite.animation == "walk_left" or animated_sprite.animation == "leap" and animated_sprite.frame == 0:
						animated_sprite.animation = "stand"
						$AnimatedSprite2D.frame = 0
				
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
