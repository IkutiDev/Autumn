class_name Player
extends CharacterBody3D


const SPEED = 5.0
@export_category("Movement")
@export var speed := 5.0
@export_group("Reference")
@export var player_animation : PlayerAnimation
@export_category("Debug")
@export var has_correct_plant_item := false

var current_velocity = Vector3.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	InputManager.movement.connect(movement)

func _exit_tree():
	InputManager.movement.disconnect(movement)

func movement(movement_vector : Vector2) -> void:
	
	current_velocity.x = movement_vector.x * speed
	current_velocity.z = movement_vector.y * speed

	
	if current_velocity:
		if Vector3.UP.cross(transform.origin + current_velocity - position).length() > 0:
			look_at(transform.origin + current_velocity, Vector3.UP)
		rotation.x = 0
		rotation.z = 0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		current_velocity.y -= gravity * delta

#	# Get the input direction and handle the movement/deceleration.
#	var direction = (transform.basis * Vector3(movement_input.x, 0, movement_input.y))
#	if direction:
#		velocity.x = direction.x
#		velocity.z = direction.z
#	else:
#		velocity.x = move_toward(velocity.x, 0, speed)
#		velocity.z = move_toward(velocity.z, 0, speed)

	velocity = current_velocity
	
	player_animation.set_player_motion(velocity.normalized().x != 0 or velocity.normalized().z != 0)
	
	move_and_slide()
