extends Node2D

var sceneLimit : Position2D
var player : KinematicBody2D

onready var music := $MusicPlayer

var currentScene = null

func _ready() -> void:
	currentScene = get_child(0)
	setLimitAndPlayer()
	# Exemplo: acessando barramentos de áudio através
	# da interface de baixo nível (AudioServer)
	print(AudioServer.bus_count)
	var lowpass : AudioEffectLowPassFilter = AudioServer.get_bus_effect(1, 0)
	print(lowpass)
	lowpass.cutoff_hz = 12500
	AudioServer.set_bus_volume_db(1, -10)
	
func _physics_process(delta: float) -> void:
	if currentScene == null or player == null:
		return
			
	if player.position.y > sceneLimit.position.y:
		#get_tree().change_scene("res://GameOver.tscn")
		call_deferred("goto_scene", "res://GameOver.tscn")
		
	#if Input.is_key_pressed(KEY_X):
	#	call_deferred("goto_scene", "res://GameOver.tscn")
		
func goto_scene(path: String):
	print("Total children: "+str(get_child_count()))
	var world := get_child(0)
	world.free()
	var res := ResourceLoader.load(path)
	currentScene = res.instance()
	sceneLimit = null
	get_tree().get_root().add_child(currentScene)
	setLimitAndPlayer()
	music.stop()
	
func setLimitAndPlayer():
	sceneLimit = currentScene.get_node("SceneLimit")
	player = currentScene.get_node("Player")	
