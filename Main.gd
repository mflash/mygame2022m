extends Node2D

const SPEED : int = 100
var total : float = 0

func _ready() -> void:
	update_score(total)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("right"):
		print("Right arrow")
	
func _process(delta: float) -> void:
	#inc_score(delta)
	update_score(total)
	
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("right"):
		position.x += SPEED * delta
	
func inc_score(incr: float) -> void:
	total += incr
	
func update_score(current_score: float) -> void:
	#get_node("Score")...
	$Score.text = "Score: " + str(current_score)

func _on_Timer_timeout() -> void:
	inc_score(1)
	
