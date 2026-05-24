extends CharacterBody3D
var sensitivity = 0.5
var captured = true
var speed = 10
var jumpheight = 5
var gravity = 10
# Camera Movement

func _ready() -> void:
	print("Captured!")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and captured == true:
		rotation_degrees.y -= event.relative.x * sensitivity
		%camera.rotation_degrees.x -= event.relative.y * sensitivity
		%camera.rotation_degrees.x = clamp(%camera.rotation_degrees.x, -90, 90)
	if event.is_action_pressed("ui_cancel"):
		if captured == true:
			captured = false
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			captured = true
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if Input.is_action_just_pressed("Increase Sensitivity"):
		sensitivity += 0.05
		print(sensitivity)
	elif Input.is_action_just_pressed("Decrease Sensitivity") and sensitivity > 0.11:
		sensitivity -= 0.05
		print(sensitivity)
	elif Input.is_action_just_pressed("Normal Sens"):
		sensitivity = 0.5
		print(sensitivity)

func _physics_process(delta: float) -> void:
	var directions := Input.get_vector("Move_Left", "Move_Right", "Move_Forward", "Move_Backwards")
	var movement := Vector3(directions.x, 0, directions.y)
	var local_movement = transform.basis * movement
	velocity.x = local_movement.x * speed
	velocity.z = local_movement.z * speed
	velocity.y -= gravity * delta
	if Input.is_action_just_pressed("Jump") and is_on_floor():
			velocity.y += jumpheight
	
	move_and_slide()
	
