extends HBoxContainer

func set_ui_from_mod(mod : Mod):
	$TextureRect.texture = mod.mod_texture
	$Label.text = mod.mod_name
	$CheckButton.pressed = mod.is_activated
	
	$CheckButton.connect("toggled" , self, "_on_check_button_toggled", [mod])
	
	
func _on_check_button_toggled(is_pressed : bool, mod : Mod):
	mod.is_activated = is_pressed
