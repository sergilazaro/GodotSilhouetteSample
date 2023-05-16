extends Spatial

onready var world_camera                   = $ViewportContainer/Viewport/World/Camera
onready var silhouette_intermediate_camera = $ViewportContainer/Viewport/ViewportSilhouettes/SilhouettesCamera
onready var final_render_camera            = $ViewportContainer/Viewport/FinalRenderCamera

func _ready():
	
	# same world for both render passes
	$ViewportContainer/Viewport/ViewportSilhouettes.world = $ViewportContainer/Viewport.world
	
	# ensure that the cameras have the same properties
	silhouette_intermediate_camera.near = world_camera.near;
	silhouette_intermediate_camera.far  = world_camera.far;
	silhouette_intermediate_camera.fov  = world_camera.fov;
	silhouette_intermediate_camera.size = world_camera.size;
	final_render_camera.near            = world_camera.near;
	final_render_camera.far             = world_camera.far;
	final_render_camera.fov             = world_camera.fov;
	final_render_camera.size            = world_camera.size;
	
	# we want this to be executed after anything that will move the camera,
	# otherwise there will be a 1 frame delay, since this script is executed first by default (being a parent).
	# higher process_priority number means it will be executed later
	process_priority = 99999
	
func _process(delta):
	
	# scale viewports
	var size = OS.get_window_size()
	$ViewportContainer.rect_size = size
	$ViewportContainer/Viewport.size = size
	$ViewportContainer/Viewport/ViewportSilhouettes.size = size
	
	world_camera.current = false
	silhouette_intermediate_camera.current = true
	final_render_camera.current = true
	
	# move cameras to match the world camera
	silhouette_intermediate_camera.global_transform = world_camera.global_transform
	final_render_camera.global_transform            = world_camera.global_transform
	
