extends Node
var score 
@export var pipe_scene: PackedScene

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _on_pipe_timer_timeout() -> void:
	var pipe = pipe_scene.instantiate()
	var pipe_position_y = randf_range(150, 550)
	pipe.position = Vector2(600, pipe_position_y)
	add_child(pipe)
	pipe.point.connect(_on_pipe_point)
 
func new_game():
	score = 0
	$hud.update_score(score)
	$hud.show_message(("Tap!"))
	$Bird.start(Vector2(100,400))
	$PipeTimer.start()

func _on_pipe_point():
	score += 1
	$hud.update_score(score)

func game_over() -> void:
	$PipeTimer.stop()
	$hud.show_game_over()
