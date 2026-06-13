extends Node

var score = 0
var game_active = false
@export var physics_pipe_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	print("point")
	$hud.update_score(score)	
	
func new_game():
	$gameStartSound.play()
	game_active = true
	score = 0
	$hud.update_score(score)
	$hud.show_message(("Tap!"))
	$PhysicsBird.start(Vector2(100,600))
	$Timer.start()	
	
func game_over() -> void:
	game_active = false
	$Timer.stop()
	$hud.show_game_over()
	$gameOverSound.play()
	
