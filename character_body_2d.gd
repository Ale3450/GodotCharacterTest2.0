extends CharacterBody2D

const SPEED=200
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity = velocity + get_gravity() * delta

# Movimiento izquierda y derecha
	if Input.is_action_pressed("izq"):
		velocity.x=-SPEED
	elif Input.is_action_pressed("der"):
		velocity.x=SPEED
	else:
		velocity.x=0
	
	if is_on_floor() and Input.is_action_just_pressed("arriba"):
		velocity.y=-300
	move_and_slide()
	
	#hacer tp
	if Input.is_action_pressed("der") and Input.is_action_just_pressed("teleport"):
		position.x +=200
	
	if Input.is_action_pressed("izq") and Input.is_action_just_pressed("teleport"):
		position.x +=-200
