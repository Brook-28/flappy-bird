extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$Timer.start()

func show_game_over():
	show_message("Game Over")
	await $Timer.timeout
	
	$Message.text = "Mr. Flappy"
	$Message.show()
	
	await get_tree().create_timer(1.0).timeout
	$Button.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)
	
	

func _on_button_pressed() -> void:
	$Button.hide()
	start_game.emit()


func _on_timer_timeout() -> void:
	$Message.hide()
