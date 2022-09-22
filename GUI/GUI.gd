extends CanvasLayer

onready var score := 0

func updateScore():
	score += 1
	$Label.text = "Score: " + str(score)
