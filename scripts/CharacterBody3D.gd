extends CharacterBody3D


const SPEED = 5.0
const SPEEDRUNNING = 7.5
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.002
var move_toggle: bool

@onready var head = $Head
@onready var camera = $Head/Camera3D

#Bob variables


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	#Handle jump and on_floor checks
	if not is_on_floor():
		velocity.y -= gravity * delta
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	move_and_slide()
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	
	if direction and Input.is_action_pressed("move_toggle"):
		velocity.x = direction.x * SPEEDRUNNING
		velocity.z = direction.z * SPEEDRUNNING
	elif direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))
