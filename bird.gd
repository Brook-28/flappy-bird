extends Area2D
signal hit

@export var jump_force = -500.0
@export var game_gravity = 5.0
var velocity = Vector2.ZERO
var screen_size
var is_dead = false

func _ready() -> void:
	screen_size = get_viewport_rect().size



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
	if position.y >= screen_size.y:
		is_dead = true
		hide()
		hit.emit()
		$CollisionShape2D.set_deferred("disabled", true)

	
	position = position.clamp(Vector2.ZERO, screen_size)

# death and pipe collision logic
func _on_body_entered(_body: Node2D):
	is_dead = true
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
