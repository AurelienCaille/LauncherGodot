extends HBoxContainer


func set_ui_from_mod(mod : Mod):
	$TextureRect.texture = mod.mod_texture
	$Label.text = mod.mod_name
	$CheckButton.pressed = mod.is_activated
