extends Area2D

const SPEED = 300


func _process(delta: float) -> void:
	var direction: Vector2 = Vector2.DOWN
	var travel: Vector2 = direction * SPEED * delta


	position += travel
	if position.y > 700:
		queue_free()
		SignalBus.raindrop_missed.emit()