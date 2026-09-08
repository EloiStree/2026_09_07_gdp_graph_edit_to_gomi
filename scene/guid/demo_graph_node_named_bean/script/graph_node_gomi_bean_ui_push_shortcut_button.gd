class_name GraphNodeGomiBeanUiPushShortcutButton
extends GraphNode

@export var _command_to_push:TextEdit
@export var _push_the_command:Button
	
func _ready() -> void:
	_push_the_command.pressed.connect(_on_pressed)
	
func _on_pressed() -> void:
	GOMI.sc(_command_to_push.text)
