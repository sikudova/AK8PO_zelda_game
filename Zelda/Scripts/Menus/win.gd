extends Control

@onready var menu_button = $MarginContainer/HBoxContainer/VBoxContainer/menu_button
@onready var again_button = $MarginContainer/HBoxContainer/VBoxContainer/again_button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/exit_button

func _ready():
	$win_sound.play()
	menu_button.button_down.connect(on_menu_down)
	again_button.button_down.connect(on_again_down)
	exit_button.button_down.connect(on_exit_pressed)

func on_menu_down():
	get_tree().change_scene_to_file("res://Scenes/Menus/menu.tscn")

func on_again_down():
	get_tree().change_scene_to_file("res://Scenes/Levels/main_level.tscn")
	
func on_exit_pressed():
	get_tree().quit()
