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
onready var text_rich_label : RichTextLabel = $CanvasLayer/HUD/WindowDialog/TabContainer/Game/ScrollContainer/PanelContainer/RichTextLabel
onready var logo_texture : TextureRect = $CanvasLayer/HUD/WindowDialog/TabContainer/Game/LogoTextureRect
onready var play_button : Button = $CanvasLayer/HUD/WindowDialog/TabContainer/Game/PlayButton
onready var xml_reader = $XMLReader

func _ready():
	_set_base_launcher()
	_set_from_project_settings()
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
	var url : String = ProjectSettings.get_setting("launcher/rss/url")
	
	#Check URL
	if not url.ends_with(".xml"):
		push_warning("url for rss news doesnt finish with .xml")
	
	$HTTPRequest.request(url)


func _load_mods():
	var mods_to_load = $CanvasLayer/HUD/WindowDialog/TabContainer/Mods._get_activated_mod()
	
	for _mod_to_load in mods_to_load:
		var mod_to_load : Mod = _mod_to_load
		_load_mod(mod_to_load)


func _load_mod(mod_to_load : Mod):
	ProjectSettings.load_resource_pack(mod_to_load.mod_path)
	

func _set_base_launcher():
	OS.window_borderless = true
	OS.window_size = ProjectSettings.get_setting("launcher/graphics/size")
	OS.center_window()

func _set_from_project_settings():
	hud.theme = load(ProjectSettings.get_setting("launcher/graphics/theme_launcher"))
	play_button.theme = load(ProjectSettings.get_setting("launcher/graphics/theme_play_button"))
	game_texture.texture = load(ProjectSettings.get_setting("launcher/graphics/texture_background"))
	logo_texture.texture = load(ProjectSettings.get_setting("launcher/graphics/texture_logo"))
	settings_menu_packed = load(ProjectSettings.get_setting("launcher/run/settings_scene"))
	scene_to_launch = ProjectSettings.get_setting("launcher/run/main_scene")
	
	var is_using_rss = ProjectSettings.get_setting("launcher/rss/is_using_rss")
	
	if is_using_rss:
		request_rss_news()
	else:
		#use file instead
		_get_default_file_text()

func _get_default_file_text():
		var file = File.new()
		var err = file.open(ProjectSettings.get_setting("launcher/rss/default_file"), File.READ)
		
		if err != OK:
			return
			
		text_rich_label.bbcode_text = file.get_as_text()

func _on_PlayButton_pressed():
	_load_mods()
	get_tree().change_scene(scene_to_launch)


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if not result == OK:
		push_warning("http request failed, rss news ignored")
		return

	text_rich_label.bbcode_text = xml_reader.read_xml_to_bbcode(body)
