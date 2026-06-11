extends RigidBody2D
signal hit

var base_scale = Vector2(1.5, 1.5)
@export var jump_force = -35000.0
var is_dead = false
var has_jumped = false

func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	
	if not is_dead:
		if Input.is_action_just_pressed("Jump"):
			linear_velocity = Vector2(0, jump_force) * delta
			has_jumped = true
	
	if not has_jumped:
		linear_velocity = Vector2.ZERO

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
