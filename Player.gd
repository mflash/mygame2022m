extends KinematicBody2D

export (int) var speed = 200
export (float) var rotation_speed = 4

onready var target := position

var velocity := Vector2.ZERO
var rotation_dir := 0

func get_8way_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	
func get_rotation_input():
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		rotation_dir += 1
	if Input.is_action_pressed("left"):
		rotation_dir -= 1
	if Input.is_action_pressed("down"):
		velocity = Vector2(-speed, 0).rotated(rotation)
	if Input.is_action_pressed("up"):
		velocity = Vector2(speed, 0).rotated(rotation)

func get_mouse_input():
	look_at(get_global_mouse_position())
	velocity = Vector2()
	if Input.is_action_pressed("down"):
		velocity = Vector2(-speed, 0).rotated(rotation)
	if Input.is_action_pressed("up"):
		velocity = Vector2(speed, 0).rotated(rotation)

func _input(event):
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()
	
func get_point_and_click():
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) < 5:
		velocity = Vector2.ZERO
		
func _physics_process(delta):
	# 1. Movimento em 8 direções
	#get_8way_input()
	
	# 2. Movimento com giro pelo teclado ("carrinho")
	#get_rotation_input()
	#rotation += rotation_dir * rotation_speed * delta
	
	# 3. Movimento com giro pelo mouse ("mira")
	#get_mouse_input()

	# 4. Movimento com clique do mouse	
	get_point_and_click()
	
	# Aplica o deslocamento calculado ou desejado
	velocity = move_and_slide(velocity)
