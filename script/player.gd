extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -800.0
@onready var player_animation: AnimatedSprite2D = $AnimatedSprite2D

var initial_y_position: float
var max_reached_y_position: float
var many_height = 0
#@onready var height: Label = $"../CanvasLayer/MarginContainer/Height"

func _physics_process(delta: float) -> void:
	#print(velocity)
	#print(delta)
	
	# Add the gravity.
	if velocity.x > 0 or velocity.x < 0:
		player_animation.animation = "run"
	
	else:
		player_animation.animation = "idle"
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		#print(velocity)
		if velocity.y < 0:
			player_animation.animation = "jump"
			many_height += 1
		
		elif velocity.y > 0:
			player_animation.animation = "fall"
			if many_height > 0:
				many_height -= 1
	
	print(many_height)
	
	# Handle jump.
	if Input.is_action_just_pressed("jump_2D") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left_2D", "right_2D")
	if direction:
		player_animation.flip_h = direction < 0
		
		velocity.x = direction * SPEED
	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
