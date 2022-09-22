extends KinematicBody2D

export (int) var speed = 100
export (float) var rotation_speed = 4
export (int) var jump_speed = 1000
export (int) var gravity = 3000

export (PackedScene) var box : PackedScene

onready var target := position
onready var sprite := $Sprite
#onready var box := preload("res://Objects/Box.tscn")

var velocity := Vector2.ZERO
var rotation_dir := 0

func get_8way_input():	
	velocity.x = Input.get_action_strength("right")-Input.get_action_strength("left")
	velocity.y = Input.get_action_strength("down")-Input.get_action_strength("up")

	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	elif velocity.y > 0:
		sprite.play("down")
	elif velocity.y < 0:
		sprite.play("up")
	else:
		sprite.stop()
		sprite.frame = 0
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
		
func get_side_input():
	velocity.x = Input.get_action_strength("right")-Input.get_action_strength("left")
	velocity.x *= speed
	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	else:
		sprite.stop()
		sprite.frame = 0

	if is_on_floor() and Input.is_action_just_pressed('jump'):
		velocity.y = -jump_speed
		get_tree().call_group("HUD", "updateScore")
		var boxNode := box.instance()
		boxNode.position = global_position
		owner.add_child(boxNode)

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
	#get_point_and_click()
	
	# 5. Movimento lateral com gravidade e saltos
	velocity.y += gravity * delta
	get_side_input()
	
	# Aplica o deslocamento calculado ou desejado
	
	velocity = move_and_slide(velocity, Vector2.UP)
