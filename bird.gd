extends RigidBody2D
signal hit

@export var jump_force = -1000.0


var screen_size
var is_dead = false
var has_jumped = false
var base_scale = Vector2(1.5, 1.5)
var jump_requested = false

func _ready() -> void:
	can_sleep = false
	screen_size = get_viewport_rect().size
	
	$CollisionShape2D.disabled = true


func _unhandled_input(event):
	if not is_dead:
		if event.is_action_pressed("Jump"):
			jump_requested = true



func _physics_process(delta: float) -> void:
	
	# player input control
	if not is_dead:
		if jump_requested:
			linear_velocity = Vector2(0 , jump_force)
			jump_requested = false
			$AudioStreamPlayer2D.play()
	print(linear_velocity.y)
			


func _process(delta: float) -> void:
		
	
	# birds streching 
	var target_scale: Vector2
	
	if linear_velocity.y < 0:
		target_scale = Vector2(0.85 * base_scale.x, 1.2 * base_scale.y)
	elif linear_velocity.y > 0:
		target_scale = Vector2(1.2 * base_scale.x, 0.85 * base_scale.y)
	else:
		target_scale = base_scale
		
	$Sprite2D.scale = $Sprite2D.scale.lerp(target_scale, 5 * delta)
	
	
	
	# direction facing logic
	rotation = linear_velocity.y * 0.001
	

	
	# touching ground and death logic
	if not is_dead:
		if position.y >= 700:
			is_dead = true
			hit.emit()
			$CollisionShape2D.set_deferred("disabled", true)

	
	

# death and pipe collision logic
func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	is_dead = true
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	freeze = true
	position = pos
	freeze = false
	is_dead = false
	has_jumped = false
	show()
	$CollisionShape2D.disabled = false
