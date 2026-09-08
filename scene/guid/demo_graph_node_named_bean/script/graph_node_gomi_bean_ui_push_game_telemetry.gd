class_name GraphNodeGomiBeanUiPushGameTelemetry
extends GraphNode

@export var _game_information_as_text:TextEdit
@export var _push_the_game_information:Button
@export var _use_text_edit_submit:bool = true

func _ready() -> void:
	_push_the_game_information.pressed.connect(_on_pressed)
	if _use_text_edit_submit:
		_game_information_as_text.text_set.connect(_on_pressed)

func _on_pressed() -> void:	
	GOMI.game_text_telemetry(_game_information_as_text.text)
