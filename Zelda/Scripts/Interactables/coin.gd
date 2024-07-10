extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		player_data.coin += 1
		queue_free()
		if player_data.coin >= 10:
			player_data.coin = 0
			player_data.health = 4
			get_tree().change_scene_to_file("res://Scenes/Menus/win.tscn")
