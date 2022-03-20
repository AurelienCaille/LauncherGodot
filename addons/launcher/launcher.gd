"""
	Main class for launcher
	
	WIP:
		- rss flux for news
	
	TODO:
		- project parameters for rss, texture and theme
		- pck loading (usefull for modding support)
"""

extends Node

export(String, FILE) var scene_to_launch


func _on_PlayButton_pressed():
	get_tree().change_scene(scene_to_launch)


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	pass # Replace with function body.
