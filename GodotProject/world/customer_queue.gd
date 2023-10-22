extends Node3D

#@export var customer_scene : PackedScene
@export var customer_speed := 1.0
@export var customer_spawn_time := 10.0
@export var customer_distance := 0.1

@export_group("References")
@export var path3D : Path3D
@export var leaving_path3D : Path3D

var active_customers : Array[PathFollow3D]
var leaving_customers : Array[PathFollow3D]
var customer_spawn_timer := 0.0

var allow_spawn := false

# Called when the node enters the scene tree for the first time.
func _ready():
	customer_spawn_timer = customer_spawn_time
	GameManager.night_summary.connect(clear_all_customers)
	GameManager.evening_starts.connect(start_spawning_customers)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if not allow_spawn:
		return
	
	for i in active_customers.size():
		var customer = active_customers[i]
		if customer.progress_ratio < 1.0 - i * customer_distance:
			customer.get_child(0).update_animation(true)
			customer.progress_ratio += delta * customer_speed
			customer.progress_ratio = min(customer.progress_ratio, 1.0 - i * customer_distance)
		if customer.progress_ratio + 0.01 >= 1.0 - i * customer_distance:
			if customer.get_child(0) != null:
				customer.get_child(0).update_animation(false)
		
	for i in range(leaving_customers.size() - 1, -1, -1):
		var customer = leaving_customers[i]
		customer.get_child(0).update_animation(true)
		customer.progress_ratio += delta * customer_speed
		if customer.progress_ratio >= 1.0:
			leaving_customers.remove_at(i)
			delete_customer(customer)
	
	if active_customers.size() >= 10:
		return
	
	if customer_spawn_timer > 0:
		customer_spawn_timer -= delta
		if customer_spawn_timer <= 0:
			var path_follower = PathFollow3D.new()
			path3D.add_child(path_follower)
			path_follower.loop = false
			path_follower.rotation_mode = PathFollow3D.ROTATION_Y
			var customer = GameManager.customers_to_spawn[GameManager.day_index].instantiate()
			path_follower.add_child(customer)
			customer.remove_customer.connect(remove_customer)
			active_customers.append(path_follower)
			customer_spawn_timer = customer_spawn_time

func remove_customer(customer : Node3D) -> void:
	active_customers.erase(customer.get_parent())
	leaving_customers.append(customer.get_parent())
	customer.get_parent().progress_ratio = 0
	customer.get_parent().reparent(leaving_path3D)

func delete_customer(customer : PathFollow3D) -> void:
	customer.queue_free()

func clear_all_customers() -> void:
	active_customers.clear()
	leaving_customers.clear()
	for child in path3D.get_children():
		child.queue_free()
	for child in leaving_path3D.get_children():
		child.queue_free()
	allow_spawn = false

func start_spawning_customers() -> void:
	allow_spawn = true
