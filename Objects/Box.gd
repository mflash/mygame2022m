extends Area2D

func _ready() -> void:
	
	# Se quiser usar o AnimationPlayer, ative a propriedade Autoplay
	# da animação "scale" e comente as linhas abaixo!
	var box := $SpriteBox
	var tween := get_tree().create_tween().set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(box, "scale", Vector2(1.5,1.5), 0.2)
	tween.parallel().tween_property(box, "modulate", Color.red, 0.2)
	tween.tween_property(box, "scale", Vector2(1,1), 0.2)
	tween.parallel().tween_property(box, "modulate", Color.white, 0.2)
	tween.tween_callback(box, "fim")
	
func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()

func fim():
	print("Fim da animação!")
