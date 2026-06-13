extends StaticBody2D

signal point
@export var speed = 250
var scored = false






func _process(delta: float) -> void:
	position += Vector2(-speed, 0) * delta
	
	#checks if the pipe passed the bird
	if position.x < 100 and not scored:
		scored = true
		point.emit()
		

# delete pipe when off screan
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
