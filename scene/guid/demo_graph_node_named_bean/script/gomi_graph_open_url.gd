class_name GomiGraphOpenUrl
extends Node

@export var _url_to_open:String

func open_url_in_inspector():
	OS.shell_open(_url_to_open)
	
func open_url( url_to_open:String):
	OS.shell_open(url_to_open)
