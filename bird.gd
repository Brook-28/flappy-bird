extends Area2D
signal hit

@export var jump_force = -500.0
@export var game_gravity = 5.0
var velocity = Vector2.ZERO
var screen_size
var is_dead = false

func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()


func _process(delta: float) -> void:
	
	# stops the bird from moving if its dead
	if is_dead:
		
		return
	
	# positional logic
	velocity.y += game_gravity
	position += velocity * delta
	
	# direction facing logic
	rotation = velocity.y * 0.001
	
	# player input control
	if Input.is_action_just_pressed("Jump"):
		velocity.y = jump_force
	
	# touching ground and death logic
	if position.y >= 700:
		is_dead = true
		hide()
		hit.emit()
		$CollisionShape2D.set_deferred("disabled", true)

	
	position = position.clamp(Vector2.ZERO, Vector2(screen_size.x, 700))

# death and pipe collision logic
func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	is_dead = true
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
