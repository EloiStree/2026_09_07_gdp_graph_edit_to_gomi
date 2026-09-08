class_name GraphNodeGomiBeanUiPushCommandToggle
extends GraphNode

@export var _command_to_push_on_true:LineEdit
@export var _command_to_push_on_false:LineEdit
@export var _push_the_command:CheckButton
	
func _ready() -> void:
	_push_the_command.toggled.connect(_on_toggled)

func _on_toggled(pressed: bool) -> void:
	if pressed:
		GOMI.cmd(_command_to_push_on_true.text)
	else:
		GOMI.cmd(_command_to_push_on_false.text)
