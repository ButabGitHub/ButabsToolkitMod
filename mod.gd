extends "GUMM_mod.gd"

func _initialize(scene_tree: SceneTree) -> void:

	var theme = load_from_file()
	print(theme)

	replace_resource_at("res://Client/NPC.png", load_texture("mod://NPC.png"))
	replace_resource_at("res://Bopimo/Client/Resources/Imported/Texture/Texture2D/CompressedTexture2D/GUI/Icons.png", load_texture("mod://Toolkit/NewIcons.png"))
	replace_resource_at("res://Client/Scenes/GUI/Interface/Interface.tscn", load_resource("mod://Toolkit/Interface.tscn"))
	#replace_resource_at("res://Client/Scripts/GUI/Interface.gd", load_resource("mod://Toolkit/Interface.gd"))

	var spawner = Themer.new()
	spawner.name = "Themer"
	spawner.gumm = self
	spawner.theme = load_resource(str("mod://Themes/", theme))
	scene_tree.root.call_deferred("add_child", spawner)

	print("		!!! Loaded Butab's complete toolkit !!!		")

func load_from_file():
	var file = FileAccess.open("user://mods/ButabsToolkitMod/current_theme.dat", FileAccess.READ)
	var content : String = file.get_as_text()
	
	return str(content)

#This class is watching for new nodes
class Themer extends Node:
	var gumm
	var theme
	var default_theme = load("res://addons/BopimoTheme/Resources/BopimoTheme.tres")
	
	func _ready():
		# Notify me on each new node.
		get_tree().node_added.connect(on_new_node)
	
	func on_new_node(node):
		if "theme" in node:
			if node.theme == default_theme and not node.name.begins_with("ThemeButton"): #Only replace if node has the default theme.
				node.theme = theme
				node.add_to_group("themed")

	func change_theme(path_to_theme : String):
		print("THEME CHANGE!")
		theme = gumm.load_resource(path_to_theme)
		for node in get_tree().get_nodes_in_group("themed"):
			node.theme = theme