extends Node

var score 
@export var pipe_scene: PackedScene
var game_active = false



func _on_pipe_timer_timeout() -> void:
	
	var pipe = pipe_scene.instantiate()
	var pipe_position_y = randf_range(150, 550)
	pipe.position = Vector2(600, pipe_position_y)
	
	add_child(pipe)
	pipe.point.connect(_on_pipe_point)
 
func new_game():
	$gameStartSound.play()
	game_active = true
	score = 0
	$hud.update_score(score)
	$hud.show_message(("Tap!"))
	$Bird.start(Vector2(100,400))
	$PipeTimer.start()
	

func _on_pipe_point():
	if not game_active:
		return
	score += 1
	$hud.update_score(score)

func game_over() -> void:
	game_active = false
	$PipeTimer.stop()
	$hud.show_game_over()
	$gameOverSound.play()
