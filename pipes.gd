extends Area2D

signal point
@export var speed = 200
var scored = false
# moves the pipe
func _process(delta: float) -> void:
	position += Vector2(-speed, 0) * delta
	
	if position.x < 100 and not scored:
		scored = true
		point.emit()

# delete the pipe when it exists the screen
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
