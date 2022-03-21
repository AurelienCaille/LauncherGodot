extends Panel


var is_following := false
var dragging_start_position : Vector2


func _process(delta):
	if is_following:
		OS.set_window_position(OS.window_position + get_global_mouse_position() - dragging_start_position)

func _on_BarWindowPanel_gui_input(event):
	if not event is InputEventMouseButton:
		return

	if not event.get_button_index() == 1:
		return
		
	is_following = !is_following
	dragging_start_position = get_local_mouse_position()


func _on_ExitButton_pressed():
	get_tree().quit()
