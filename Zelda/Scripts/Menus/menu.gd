extends Control

@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/start_button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/exit_button
@onready var start_level = preload("res://Scenes/Levels/main_level.tscn")

func _ready():
	start_button.button_down.connect(on_start_down)
	exit_button.button_down.connect(on_exit_pressed)

func on_start_down():
	get_tree().change_scene_to_file("res://Scenes/Levels/main_level.tscn")
	
func on_exit_pressed():
	get_tree().quit()
