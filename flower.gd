extends Area2D

# movement / time
const SPEED = 400

# delta = time / frame
func _process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var travel: Vector2 = direction * SPEED * delta

	if position.y + travel.y < 450 or position.y + travel.y > 580:
		travel.y = 0
	if position.x + travel.x < 50 or position.x + travel.x > 1000:
		travel.x = 0
	position += travel

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(_other: Area2D):
	_other.queue_free()
	SignalBus.raindrop_collected.emit()
