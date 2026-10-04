extends CharacterBody2D

const SPEED=200
var dentro_del_area = false
var contador = 0
var correr = 0
var velEnZonaFrenesi = 0

func _ready ():
	$AnimatedSprite2D.sprite_frames.set_animation_loop_mode("die",SpriteFrames.LoopMode.LOOP_NONE)

#nombre de la funcion principal
func _physics_process(delta: float) -> void:
	# Añadir gravedad.
	if not is_on_floor():
		velocity = velocity + get_gravity() * delta
	else:
		contador = 0
# Movimiento izquierda, derecha y arriba, el salto triple y la muertew
	if dentro_del_area == true:
		velocity.y=0
	if dentro_del_area == true:
		velocity.x=0
	elif Input.is_action_pressed("izq"):
		velocity.x=-SPEED+(-correr)+(-velEnZonaFrenesi)
	elif Input.is_action_pressed("der"):
		velocity.x=SPEED+correr+velEnZonaFrenesi
	else:
		velocity.x=0
	if Input.is_action_just_pressed("arriba") and contador<3:
		velocity.y=-300
		contador +=1
		$AnimatedSprite2D.stop()
	
	#Logica para el sprint
	if Input.is_action_pressed("correr"):
		correr=SPEED*2
	else:
		correr=0
	#hacer tp
	if Input.is_action_pressed("der") and Input.is_action_just_pressed("teleport"):
		position.x +=200
	
	if Input.is_action_pressed("izq") and Input.is_action_just_pressed("teleport"):
		position.x +=-200

	#logica para la caida de plomo
	if not is_on_floor and Input.is_action_pressed("correr"):
		velocity.y+=100
		velocity.x = 0
	#Animaciones
	if dentro_del_area==true:
		$AnimatedSprite2D.play("die")
	elif velocity.x == 0 and velocity.y==0 :
		$AnimatedSprite2D.play("quieto")
	elif velocity.x>0 and velocity.y==0:
		$AnimatedSprite2D.flip_h=false
		$AnimatedSprite2D.play("caminar")
	elif velocity.x<0 and velocity.y==0:
		$AnimatedSprite2D.flip_h=true
		$AnimatedSprite2D.play("caminar")
	elif velocity.y<0:
		$AnimatedSprite2D.play("salto")
	move_and_slide()
	#habilidad escalada
	if is_on_wall() and Input.is_action_pressed("arriba"):
		velocity.y=-200
	elif is_on_wall() and velocity.y>0:
		velocity.y=10
#Otras funciones #########
func _on_area_muerte_body_entered(body: Node2D) -> void:
	if body.name == "OldMan":
		print ("Entraste a la muerte")
		dentro_del_area=true

func _on_area_noMuerte_body_exited(body: Node2D) -> void:
	print ("Saliste de la muerte")
	dentro_del_area=false

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "die":
		print ("VE AL PARQUE POR FAVOR")
		print ("Gracias por jugar")
		get_tree().quit()

func _on_zona_frenesí_body_entered(body: Node2D) -> void:
	if body.name == "OldMan":
		velEnZonaFrenesi = SPEED * 2

func _on_zona_frenesí_body_exited(body: Node2D) -> void:
	velEnZonaFrenesi = 0


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not dentro_del_area:
		dentro_del_area = true
		$AnimatedSprite2D.play("die")
		print("El enemigo te mató")
