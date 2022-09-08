extends Node2D

var total : float = 0

func _ready() -> void:
	update_score(total)
	
func _process(delta: float) -> void:
	#inc_score(delta)
	update_score(total)
	
func inc_score(incr: float) -> void:
	total += incr
	
func update_score(current_score: float) -> void:
	#get_node("Score")...
	$Score.text = "Score: " + str(current_score)

func _on_Timer_timeout() -> void:
	inc_score(1)
	
