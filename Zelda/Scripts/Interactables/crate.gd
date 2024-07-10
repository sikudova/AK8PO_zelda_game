extends StaticBody2D

func _on_hitbox_area_entered(area):
	if area.name == "sword":
		$anim.play("Destroyed")
		await $anim.animation_finished
		queue_free()
