extends Area2D
signal hit

@export var jump_force = -500.0
@export var game_gravity = 5.0
var velocity = Vector2.ZERO
var screen_size
var is_dead = true
var max_rotation = 0

func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()
	$CollisionShape2D.disabled = true

func _process(delta: float) -> void:
	
	
	
	
	# positional logic
	velocity.y += game_gravity
	position += velocity * delta
	
	# direction facing logic
	if not is_dead:
		rotation = velocity.y * 0.001
	else:
		rotation = min(rotation + 0.04, PI / 2)
		
	# player input control
	if not is_dead:
		if Input.is_action_just_pressed("Jump"):
			velocity.y = jump_force
			$AudioStreamPlayer2D.play()
	
	# touching ground and death logic
	if not is_dead:
		if position.y >= 700:
			is_dead = true
			hit.emit()
			$CollisionShape2D.set_deferred("disabled", true)

	
	position = position.clamp(Vector2.ZERO, Vector2(screen_size.x, 700))

# death and pipe collision logic
func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	is_dead = true
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	velocity = Vector2(0, 100)
	is_dead = false
	show()
	$CollisionShape2D.disabled = false
