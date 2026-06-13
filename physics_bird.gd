extends RigidBody2D
signal hit

var base_scale = Vector2(1.5, 1.5)
@export var jump_force = -33000.0
var is_dead = false
var has_jumped = false
var was_hit = false

func _ready() -> void:
	freeze = true
	hide()


func _physics_process(delta: float) -> void:
	
	# player input
	if not is_dead:
		if Input.is_action_just_pressed("Jump"):
			
			linear_velocity = Vector2(0, jump_force * 1.2) * delta
			has_jumped = true
			freeze = false
			
	
	# disable movement before jump
	if not has_jumped:
		freeze = true

func _process(delta: float) -> void:
	
	

	
	rotation = linear_velocity.y * 0.001
	
	# birds streching 
	var target_scale: Vector2
	
	if linear_velocity.y < 0:
		target_scale = Vector2(0.85 * base_scale.x, 1.2 * base_scale.y)
	elif linear_velocity.y > 0:
		target_scale = Vector2(1.2 * base_scale.x, 0.85 * base_scale.y)
	else:
		target_scale = base_scale
		
	$Sprite2D.scale = $Sprite2D.scale.lerp(target_scale, 5 * delta)
	
# death and pipe collision logic
func _hit_pipe(_body):
	if not was_hit:
		is_dead = true
		hit.emit()
		was_hit = true
	
# start conditions
func start(pos):
	was_hit = false
	freeze = true
	position = pos
	freeze = false
	is_dead = false
	has_jumped = false
	show()
	$CollisionShape2D.disabled = false
