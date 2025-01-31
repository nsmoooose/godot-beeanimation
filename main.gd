extends Node2D

@export var frame_count_total: int = 600

var frame_count: int = 0
var output_folder: String = "frames/"
var capturing: bool = false

func _ready():
	pass
	
func _process(delta: float):
	if capturing:
		# First frame is black for some reason.
		if frame_count == 0:
			frame_count += 1
			return

		save_frame()
		if frame_count >= frame_count_total:
			get_tree().quit()

func save_frame():
	var filename = output_folder + "frame_%04d.png" % frame_count
	var viewport = get_viewport()
	var image = viewport.get_texture().get_image()
	image.flip_y()  # Flip image vertically to correct orientation
	image.save_png(filename)
	print("Saved frame: %s" % filename)
	frame_count += 1
