extends CharacterBody3D
var sensitivity : float = 0.5
@export var captured : bool = true
var speed : int = 10
var acceleration : int  = 67
var jumpheight : int = 33
var gravity : int = 100
var coyotetimer : float = 0.0
var coyotetime : float = 0.09
var jumpbuffer : float = 0.09
var jumpbuffertimer :float = 1.0   
var jumped : bool = false
var dashspeed : int = 30
var dashed : bool = false
var dashtimer : float = 0.0
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
	var directions : Vector2 = Input.get_vector("Move_Left", "Move_Right", "Move_Forward", "Move_Backwards")
	var movement : Vector3 = Vector3(directions.x, 0, directions.y).normalized()
	var local_movement : Vector3 = transform.basis * movement
	#velocity.x += local_movement.x * speed * delta
	#velocity.x = clamp(velocity.x, -speed, speed)
	#velocity.z += local_movement.z * speed * delta
	#velocity.z = clamp(velocity.z, -speed, speed)
	velocity.x = move_toward(velocity.x, local_movement.x*speed, acceleration*delta)
	velocity.z = move_toward(velocity.z, local_movement.z*speed, acceleration*delta)
	velocity.y -= gravity * delta
	if is_on_floor():
		coyotetimer = 0.0
		jumped = false
	else:
		coyotetimer += delta
	jumpbuffertimer += delta
	if Input.is_action_just_pressed("Jump") and jumped == false and (is_on_floor() or coyotetimer <= coyotetime):
		velocity.y = jumpheight
		jumped = true
	elif is_on_floor() and jumpbuffertimer <= jumpbuffer:
		velocity.y = jumpheight
		jumped = true
	elif Input.is_action_just_pressed("Jump"):
		jumpbuffertimer = 0.0
	
	## VELOCITY BOOST + GRAVITY PAUSE DASH
	if Input.is_action_just_pressed("Dash") and dashed == false:
		var vec = Vector3(0,0,-1)
		var dir = transform.basis * vec
		velocity.z += dir.z * dashspeed
		velocity.x += dir.x * dashspeed
		dashtimer = 0.0
		dashed = true
	dashtimer += delta
	if dashtimer > 0.7:
		dashed = false	
	elif dashtimer <= 0.25:
		velocity.y = clamp(velocity.y, 0, INF)
		
	## SPEED DASH
	#if Input.is_action_just_pressed("Dash") and dashed == false:
		#speed = 25
		#dashtimer = 0.0
		#dashed = true
	#dashtimer += delta
	#if dashtimer > 0.7:
		#dashed = false
	#elif dashtimer >= 0.2:
		#speed = 10
	move_and_slide()
	
