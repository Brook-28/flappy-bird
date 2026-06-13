extends Node

var high_score = 0
var score = 0
var game_active = false
@export var physics_pipe_scene: PackedScene


func _ready() -> void:
	load_high_score()
	$hud.update_high_score(high_score)


func _process(delta: float) -> void:
	# moving grass
	$ground/grass_sprite.position += Vector2(-250, 0) * delta
	if $ground/grass_sprite.position.x <= -10:
		$ground/grass_sprite.position.x = 540


	
func _on_timer_timeout() -> void:
		
	var pipe = physics_pipe_scene.instantiate()
	var pipe_position_y = randf_range(210, 480)
	pipe.position = Vector2(600, pipe_position_y)
	
	add_child(pipe)
	pipe.point.connect(_on_pipe_point)
	
func _on_pipe_point():
	if not game_active:
		return
	score += 1
	$hud.update_score(score)	
	if score > high_score:
		high_score = score
		save_high_score()
		$hud.update_high_score(high_score)
		print(high_score)
		
func new_game():
	$gameStartSound.play()
	game_active = true
	score = 0
	$hud.update_score(score)
	$hud.show_message(("Tap!"))
	$PhysicsBird.start(Vector2(100,400))
		
	
func game_over():
	game_active = false
	$Timer.stop()
	$hud.show_game_over()
	$gameOverSound.play()
	

func save_high_score():
	var file = FileAccess.open("user://high_score.dat", FileAccess.WRITE)
	file.store_var(high_score)

func load_high_score():
	if FileAccess.file_exists("user://high_score.dat"):
		var file = FileAccess.open('user://high_score.dat', FileAccess.READ)
		high_score = file.get_var()
		
func _on_physics_bird_jumped() -> void:
	$Timer.start()


func _on_physics_bird_jump() -> void:
	$gameJumpSound.play()
