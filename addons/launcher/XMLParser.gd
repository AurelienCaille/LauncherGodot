extends Node


func read_xml_to_bbcode(xml_body : PoolByteArray) -> String:
	"""
		Read and parse an xml to pretty bbcode text
		
		XML parsing inspired by https://medium.com/@triptych/creating-an-rss-reader-in-godot-part-2-ab8a88195503
	"""

	var bb_text : String
	var parser = XMLParser.new()
	
	parser.open_buffer(xml_body)
	
	var in_item_node = false
	var in_title_node = false
	var in_description_node = false
	var in_link_node = false
	
	while parser.read() == OK:
		var node_name = parser.get_node_name()
		var node_data = parser.get_node_data()
		var node_type = parser.get_node_type()
		
		if(node_name == "item"):   
		   in_item_node = !in_item_node #toggle item mode   
		if (node_name == "title") and (in_item_node == true):     
		   in_title_node = !in_title_node   
		   continue    
		if(node_name == "description") and (in_item_node == true):     
		   in_description_node = !in_description_node   
		   continue     
		if(node_name == "link") and (in_item_node == true):   
		   in_link_node = !in_link_node   
		   continue
	
	
		if(in_description_node == true):   
			# print("description-data" + node_data)   
			if(node_data != ""):    
				bb_text += bb_desc(node_data)   
			else:    
				# print("description:" + node_name)       
				bb_text += bb_desc(node_name)    
		if(in_title_node == true):   
			# print("Title-data:"+ node_data)   
			if(node_data !=""):    
				bb_text += bb_title(node_data)   
			else:    
				# print("Title:" + node_name)    
				bb_text += bb_title(node_name)   
		if(in_link_node == true):   
			# print("link-desc" + node_data)   
			if(node_data != ""):    
				bb_text += bb_link(node_data)   
			else:    
				# print("link" + node_name)    
				bb_text += bb_link(node_name)
	
	return bb_text


func bb_desc(text):
	return "\n " + text


func bb_title(text):
	return "[b][center]" + text + "[/center][/b]"


func bb_link(text):
	return ""
