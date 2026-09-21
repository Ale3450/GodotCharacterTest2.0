extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _processI(delta: float) -> void:
	var variable ="izq"
	if Input.is_action_just_pressed("izq"):
		print ("se pulso izq")
	if Input.is_action_pressed("der"):
		print ("se pulso der")
	if Input.is_action_just_released("arriba"):
		print ("se levantó la tecla")
