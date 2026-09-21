extends CharacterBody2D

const SPEED=200
var dentro_del_area = false

func ready ():
	$AnimatedSprite2D.sprite_frames.set_animation_loop_mode("die",SpriteFrames.LoopMode.LOOP_NONE)
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

	if dentro_del_area=true:
		 $AnimatedSprite2D.play("die")

func _on_area_muerte_body_entered(body: Node2D) -> void:
	print ("Entraste a la muerte")
	dentro_del_area=true


func _on_area_noMuerte_body_exited(body: Node2D) -> void:
	print ("Saliste de la muerte")


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "die":
		print ("VE AL PARQUE POR FAVOR")
		print ("Gracias por jugar")
		get_tree().quit()
