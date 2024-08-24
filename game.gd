extends Node2D

const RAINDROP = preload("res://raindrop.tscn")

var score: int = 0
var lives: int = 5

var spawn_timer: float = 1

@onready var scorelabel = $Score
@onready var liveslabel = $Lives
@onready var youloselabel = $YouLose

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.raindrop_collected.connect(_on_raindrop_collected)
	SignalBus.raindrop_missed.connect(_on_raindrop_missed)
	scorelabel.text = "0"
	liveslabel.text = ""
	for i in range(lives):
		liveslabel.text += "❤️"
	create_raindrop()


func _on_raindrop_collected():
	score += 1
	scorelabel.text = str(score)

func _on_raindrop_missed():
	lives -= 1
	liveslabel.text = ""
	for i in range(lives):
		liveslabel.text += "❤️"

func create_raindrop():
	var raindrop = RAINDROP.instantiate()
	raindrop.position = Vector2(randf_range(20, 1000), randf_range(20, 30))
	add_child(raindrop)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spawn_timer < 0:
		create_raindrop()
		spawn_timer = 1
	spawn_timer -= delta
	if lives == 0:
		youloselabel.show()
