extends CharacterBody3D
var sensitivity = 0.5
var captured = true
func _ready() -> void:
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
