extends CharacterBody2D

@onready var anim_tree = $anim_tree
@onready var anim_state = anim_tree.get("parameters/playback")

enum player_states {
	MOVE,
	SWORD,
	JUMP,
	DEAD
}
var current_states = player_states.MOVE

var input_movement = Vector2.ZERO
var speed = 70

func _ready():
	$game_sound.play()
	$sword/CollisionShape2D.disabled = true

func _physics_process(delta):
	match current_states:
		player_states.MOVE:
			move()
		player_states.SWORD:
			sword()
		player_states.JUMP:
			jump()
		player_states.DEAD:
			dead()

func move():
	input_movement = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input_movement != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", input_movement)
		anim_tree.set("parameters/Walk/blend_position", input_movement)
		anim_tree.set("parameters/Sword/blend_position", input_movement)
		anim_tree.set("parameters/Jump/blend_position", input_movement)
		anim_state.travel("Walk")
		velocity = input_movement * speed
		
	if input_movement == Vector2.ZERO:
		anim_state.travel("Idle")
		velocity = Vector2.ZERO
		
	if Input.is_action_just_pressed("sword"):
		$sword_sound.play()
		current_states = player_states.SWORD
	
	if Input.is_action_just_pressed("jump"):
		$jump_sound.play()
		current_states = player_states.JUMP
	
	if player_data.health <= 0:
		$game_over_sound.play()
		current_states = player_states.DEAD
	
	move_and_slide()
	
func sword():
	anim_state.travel("Sword")
	
func on_states_reset():
	current_states = player_states.MOVE

func jump():
	anim_state.travel("Jump")
	velocity = input_movement * speed	
	move_and_slide()

func dead():
	anim_state.travel("Dead")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/Menus/loss.tscn")
	player_data.health = 4
	player_data.coin = 0

func clear_collision():
	$CollisionShape2D.disabled = true
	
func create_collision():
	$CollisionShape2D.disabled = false

func _on_hitbox_area_entered(area):
	if area.is_in_group("enemy"):
		$pain_sound.play()
		player_data.health -= 1
		flash()
		
func flash():
	$"Player-rpg".material.set_shader_parameter("flash_modifier", 0.7)
	await get_tree().create_timer(0.3).timeout
	$"Player-rpg".material.set_shader_parameter("flash_modifier", 0)

func _on_coin_body_entered(body):
	$coin_collect_sound.play()
