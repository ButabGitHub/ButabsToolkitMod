extends "GUMM_mod.gd"

func _initialize(scene_tree: SceneTree) -> void:

	var theme = load_from_file()
	print(theme)

	replace_resource_at("res://Client/NPC.png", load_texture("mod://NPC.png"))
	replace_resource_at("res://Bopimo/Client/Resources/Imported/Texture/Texture2D/CompressedTexture2D/GUI/Icons.png", load_texture("mod://Toolkit/NewIcons.png"))
	replace_resource_at("res://Client/Scenes/GUI/Interface/Interface.tscn", load_resource("mod://Toolkit/Interface.tscn"))
	#replace_resource_at("res://Client/Scripts/GUI/Interface.gd", load_resource("mod://Toolkit/Interface.gd"))

	# lazy theme loading implementation which (hopefully) will be changed in future
	replace_resource_at("res://addons/BopimoTheme/Resources/BopimoTheme.tres", load_resource(str("mod://Themes/", theme)))

	print("		!!! Loaded Butab's complete toolkit !!!		")

func load_from_file():
	var file = FileAccess.open("user://mods/ButabsToolkitMod/current_theme.dat", FileAccess.READ)
	var content : String = file.get_as_text()
	
	return str(content)
