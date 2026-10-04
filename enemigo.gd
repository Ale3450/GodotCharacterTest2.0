extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	
	if not $detectorSueloD.is_colliding():
		velocity.x = -SPEED
	if not $detectorSueloI.is_colliding():
		velocity.x = SPEED
	if $detectorParedD.is_colliding():
		velocity.x = -SPEED
	if $detectorParedI.is_colliding():
		velocity.x = SPEED
	move_and_slide()
