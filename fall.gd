extends Area3D
func _on_body_entered(body):
	if body == %Player:
		body.set_physics_process(false)
		body.velocity = Vector3(0,0,0)
		%Cursor.visible = false
		%Respawn.disabled = false
		%Respawn.visible = true
		%Died.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		%Player.captured = false


func _on_respawn_pressed() -> void:
	%Player.global_position = Vector3(0,5,0)
	%Player.set_physics_process(true)
	%Cursor.visible = true
	%Respawn.disabled = true
	%Respawn.visible = false
	%Died.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	%Player.captured = true
