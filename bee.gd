extends Node2D

# Movement parameters
@export var movement_speed: float = 1.0
@export var movement_range: float = 300.0
@export var noise_scale: float = 0.2
@export var center_pull_strength: float = 0.1  # How strongly the fly is pulled to the center

# Internal variables
var noise: FastNoiseLite
var time: float = 0.0
var velocity: Vector2 = Vector2.ZERO

func _ready():
	# Initialize the noise generator
	noise = FastNoiseLite.new()
	noise.seed = randi()  # Use a random seed for unique movement patterns
	noise.frequency = 0.8  # Adjust for smoother or rougher noise

func _process(delta: float):
	time += delta * noise_scale

	# Calculate smooth random movement using FastNoiseLite
	var noise_x = noise.get_noise_2d(time, 0.0) * movement_range
	var noise_y = noise.get_noise_2d(0.0, time) * movement_range

	# Compute the pull force toward the center of the screen
	var screen_center = get_viewport_rect().size / 2
	var to_center = (screen_center - position) * center_pull_strength

	# Combine random noise movement and the pull toward the center
	velocity = Vector2(noise_x, noise_y) + to_center

	# Update the fly's position
	position += velocity * delta * movement_speed

	# Rotate the fly to match its movement direction
	if velocity.length() > 0.01:  # Avoid unnecessary rotation when the movement is negligible
		rotation = velocity.angle()

	# Keep the fly within screen bounds
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)
	position.y = clamp(position.y, 0, get_viewport_rect().size.y)
