
class_name GomiGraphTextEditMemory
extends Node


@export var text_edit: TextEdit
@export var user_relative_file_path: String = "gomi_graph_memory/GUID"

var _is_shutting_down: bool = false
var _has_saved_on_exit: bool = false


func _ready() -> void:
	load_text()


func _notification(what: int) -> void:
	match what:
		NOTIFICATION_WM_CLOSE_REQUEST:
			_handle_exit_notification()

		NOTIFICATION_WM_GO_BACK_REQUEST:
			# Useful for Android/mobile back-button behavior.
			_handle_exit_notification()


func _exit_tree() -> void:
	# Fallback in case the node is removed without receiving
	# the application close notification.
	if not _has_saved_on_exit:
		save_text()


func _handle_exit_notification() -> void:
	if _is_shutting_down:
		return

	_is_shutting_down = true

	print(
		"GomiGraphTextEditMemory: Application exit requested. "
		+ "Saving text to: %s"
		% get_user_file_path()
	)

	save_text()
	_has_saved_on_exit = true

	# Godot normally handles the close request after this notification.
	# Do not call quit() here unless this node is responsible for
	# controlling the application's shutdown.


func save_text() -> bool:
	if text_edit == null:
		push_warning(
			"GomiGraphTextEditMemory: TextEdit is not assigned."
		)
		return false

	if user_relative_file_path.is_empty():
		push_warning(
			"GomiGraphTextEditMemory: File path is empty."
		)
		return false

	var file_path := get_user_file_path()
	var directory_path := file_path.get_base_dir()
	var absolute_directory_path := ProjectSettings.globalize_path(
		directory_path
	)

	# Create the directory if necessary.
	if not DirAccess.dir_exists_absolute(absolute_directory_path):
		var error := DirAccess.make_dir_recursive_absolute(
			absolute_directory_path
		)

		if error != OK:
			push_error(
				"GomiGraphTextEditMemory: Failed to create directory: %s"
				% absolute_directory_path
			)
			return false

	# Open the file for writing.
	var file := FileAccess.open(file_path, FileAccess.WRITE)

	if file == null:
		push_error(
			"GomiGraphTextEditMemory: Failed to open file for writing: %s"
			% file_path
		)
		return false

	file.store_string(text_edit.text)
	file.close()

	print(
		"GomiGraphTextEditMemory: Text saved successfully: %s"
		% file_path
	)

	return true


func load_text() -> bool:
	if text_edit == null:
		push_warning(
			"GomiGraphTextEditMemory: TextEdit is not assigned."
		)
		return false

	if user_relative_file_path.is_empty():
		push_warning(
			"GomiGraphTextEditMemory: File path is empty."
		)
		return false

	var file_path := get_user_file_path()

	# Nothing has been saved yet.
	if not FileAccess.file_exists(file_path):
		return true

	var file := FileAccess.open(file_path, FileAccess.READ)

	if file == null:
		push_error(
			"GomiGraphTextEditMemory: Failed to open file for reading: %s"
			% file_path
		)
		return false

	text_edit.text = file.get_as_text()
	file.close()

	print(
		"GomiGraphTextEditMemory: Text loaded successfully: %s"
		% file_path
	)

	return true


func get_user_file_path() -> String:
	return "user://" + user_relative_file_path


func clear_saved_text() -> bool:
	if user_relative_file_path.is_empty():
		push_warning(
			"GomiGraphTextEditMemory: File path is empty."
		)
		return false

	var file_path := get_user_file_path()

	if not FileAccess.file_exists(file_path):
		return true

	var absolute_file_path := ProjectSettings.globalize_path(
		file_path
	)

	var error := DirAccess.remove_absolute(absolute_file_path)

	if error != OK:
		push_error(
			"GomiGraphTextEditMemory: Failed to delete file: %s"
			% file_path
		)
		return false

	print(
		"GomiGraphTextEditMemory: Saved text cleared: %s"
		% file_path
	)

	return true
