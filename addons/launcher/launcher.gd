"""
	Main class for launcher
	
	WIP:
		- rss flux for news
	
	TODO:
		- project parameters for rss
		- pck loading (usefull for modding support)
"""

extends Node

export(String, FILE) var scene_to_launch
export(PackedScene) var settings_menu_packed


onready var settings_hud : Control = $CanvasLayer/HUD/WindowDialog/TabContainer/Settings
onready var hud : Control = $CanvasLayer/HUD
onready var game_texture : TextureRect = $CanvasLayer/HUD/WindowDialog/TabContainer/Game/TextureRect

func _ready():
	_set_from_project_settings()
	request_rss_news()
	set_settings_hud()

func set_settings_hud():
	if settings_menu_packed == null:
		settings_hud.queue_free()
		return
	
	# clean	
	for child in settings_hud.get_children():
		child.queue_free()
		
	
	# new scene from pack
	var new_settings_menu_packed = settings_menu_packed.instance()
	settings_hud.add_child(new_settings_menu_packed)
	
func request_rss_news():
	$HTTPRequest.request("http://rss.cnn.com/rss/edition.rss")

func _set_from_project_settings():
	hud.theme = load(ProjectSettings.get_setting("launcher/graphics/theme_launcher"))
	game_texture.texture = load(ProjectSettings.get_setting("launcher/graphics/texture_background"))


func _on_PlayButton_pressed():
	get_tree().change_scene(scene_to_launch)


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	pass # Replace with function body.
