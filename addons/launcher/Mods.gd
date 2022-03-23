extends Control

const PATH_MODS_DIRECTORY = "user://mods/"

var mods : Array

export(PackedScene) var mod_presentation = preload("res://addons/launcher/ModPresentationHUD.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	_set_hud_mods()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _set_hud_mods():
	var mod_dir = Directory.new()
	
	if not mod_dir.dir_exists(PATH_MODS_DIRECTORY):
		_make_mods_directory(mod_dir)
	
	_get_mods_from_mods_directory(mod_dir)
	_set_hud_from_mods()


func _get_activated_mod() -> Array:
	var activated_mods := []
	for _mod in mods:
		var mod : Mod = _mod
		
		if mod.is_activated:
			activated_mods.append(mod)
			
	return activated_mods

func _get_mods_from_mods_directory(_mod_dir : Directory):
	mods = []

	_mod_dir.open(PATH_MODS_DIRECTORY)
	_mod_dir.list_dir_begin(true, true)
	var file : String = _mod_dir.get_next()
	
	while file != "":
		if file.ends_with(".pck"):
			var new_mod = Mod.new()
			new_mod.mod_name = file.get_file() #TODO mod informations
			new_mod.mod_texture = preload("res://icon.png") #TODO mod informations
				
			mods.append(new_mod)
			
		file = _mod_dir.get_next()
			
	_mod_dir.list_dir_end()

func _make_mods_directory(_mod_dir : Directory):
	_mod_dir.make_dir(PATH_MODS_DIRECTORY)



func _set_hud_from_mods():
	for _mod in mods:
		var mod : Mod = _mod
		var new_mod_presentation = mod_presentation.instance()
		
		$VBoxContainer.add_child(new_mod_presentation)
		new_mod_presentation.set_ui_from_mod(mod)
