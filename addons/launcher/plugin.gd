tool
extends EditorPlugin


func _enter_tree():
	# Set launcher as starting scene
	ProjectSettings.set_setting("application/run/main_scene", "res://addons/launcher/launcher.tscn")
	
	# Set texture background settings
	if not ProjectSettings.has_setting("launcher/graphics/texture_background"):
		ProjectSettings.set_setting("launcher/graphics/texture_background", "res://icon.png")
		ProjectSettings.add_property_info({
			"name": "launcher/graphics/texture_background",
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_FILE
		})
		
		
	if not ProjectSettings.has_setting("launcher/graphics/texture_logo"):
		ProjectSettings.set_setting("launcher/graphics/texture_logo", "res://icon.png")
		ProjectSettings.add_property_info({
			"name": "launcher/graphics/texture_logo",
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_FILE
		})
		
		
	# Set theme launcher settings
	if not ProjectSettings.has_setting("launcher/graphics/theme_launcher"):
		ProjectSettings.set_setting("launcher/graphics/theme_launcher", "")
		ProjectSettings.add_property_info({
			"name": "launcher/graphics/theme_launcher",
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_FILE
		})
		
	
	# Set main scene settings
	if not ProjectSettings.has_setting("launcher/run/main_scene"):
		ProjectSettings.set_setting("launcher/run/main_scene", "")
		ProjectSettings.add_property_info({
			"name": "launcher/run/main_scene",
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_FILE
		})
		
	# Set main scene settings
	if not ProjectSettings.has_setting("launcher/run/settings_scene"):
		ProjectSettings.set_setting("launcher/run/settings_scene", "")
		ProjectSettings.add_property_info({
			"name": "launcher/run/settings_scene",
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_FILE
		})
		
	# Set rss settings
	if not ProjectSettings.has_setting("launcher/rss/is_using_rss"):
		ProjectSettings.set_setting("launcher/rss/is_using_rss", false)
		ProjectSettings.add_property_info({
			"name": "launcher/rss/is_using_rss",
			"type": TYPE_BOOL
		})
		
		
	if not ProjectSettings.has_setting("launcher/rss/default_file"):
		ProjectSettings.set_setting("launcher/rss/default_file", false)
		ProjectSettings.add_property_info({
			"name": "launcher/rss/default_file",
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_FILE
		})
		
	ProjectSettings.save()

func _exit_tree():
	pass
