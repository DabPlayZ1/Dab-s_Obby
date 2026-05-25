extends Area3D
func _on_body_entered(body):
	if body.name == "Player":
		body.set_physics_process(false)
		body.velocity = Vector3(0,0,0)
		%Cursor.visible = false
		%Respawn.disabled = false
		%Respawn.visible = true
		%Died.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		%Player.captured = false
