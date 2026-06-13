extends RigidBody2D
signal hit
signal jumped
signal jump

var base_scale = Vector2(1.5, 1.5)
@export var jump_force = -33000.0
var is_dead = false
var has_jumped = false
var was_hit = false
var jump_requested = false



func _ready() -> void:
	freeze = true
	hide()

func _unhandled_input(event):
	if not is_dead:
		if event.is_action_pressed("Jump"):
			jump_requested = true
			


func _physics_process(delta: float) -> void:
	
	# player input
	if not is_dead:
		if jump_requested:
			jump.emit()
			jump_requested = false
			if Input.is_action_just_pressed("Jump"):
				linear_velocity = Vector2(0, jump_force * 1.2) * delta
				if not has_jumped:
					jumped.emit()
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
	PhysicsServer2D.body_set_state(get_rid(), PhysicsServer2D.BODY_STATE_TRANSFORM, Transform2D(0, pos))
	freeze = false
	is_dead = false
	has_jumped = false
	show()
	$CollisionShape2D.disabled = false
