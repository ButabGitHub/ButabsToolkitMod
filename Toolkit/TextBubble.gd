extends HBoxContainer
class_name TextBubble

static var FONT : FontFile = load("res://addons/BopimoTheme/Resources/Fonts/Quicksand.ttf") if not ProjectSettings.get_setting_with_override("bopimo/server") else null
static var BUBBLE_SCENE: PackedScene = load("res://Client/Scenes/GUI/Text/TextBubbleInstance.tscn") if not ProjectSettings.get_setting_with_override("bopimo/server") else null

const MIN_WIDTH: float = 57.0
const MAX_WIDTH: float = 482.0
const FADE_TIME: float = 1.8

var position_to_lerp_to: Vector2 = Vector2.ZERO

@onready var bubble : NinePatchRect = get_node("Bubble")
@onready var text_label : RichTextLabel = get_node("Bubble/Text")
@onready var tail : TextureRect = get_node("Bubble/BubbleTail")

@export var bchat_color : Color

func _ready() -> void:
	if Time.get_date_dict_from_system().month == Time.MONTH_DECEMBER:
		if Time.get_date_dict_from_system().day == 25:
			tail.texture.region.position.x = 47
			bubble.texture.region.position.x = 37

static func create(reciever : Node, message : String) -> TextBubble:
	var new : TextBubble = BUBBLE_SCENE.instantiate()
	reciever.add_child(new)
	new.text_label.text = "[center]" + message + "[/center]"
	var string_size : Vector2 = FONT.get_string_size(message)

	var new_size : Vector2 = Vector2(clampf(string_size.x,MIN_WIDTH,MAX_WIDTH),new.text_label.size.y) + Vector2(25,0)
	new.bubble.custom_minimum_size = new_size

	return new

func remove() -> void: # Fade out
	var fade_tween: Tween = create_tween()
	fade_tween.tween_property(self,"modulate",Color.TRANSPARENT,FADE_TIME)
	fade_tween.tween_callback(queue_free)


func _on_fade_time_timeout() -> void:
	remove()

func _process(delta: float) -> void:
	$Bubble.material.shader_parameter.replace_color = bchat_color
	
	#tail.position.x = (bubble.size.x / 2) - (tail.size.x / 2)
	position = lerp(position,position_to_lerp_to,delta * 6.0)
