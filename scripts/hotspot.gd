extends Area2D

func _on_body_entered(body: PhysicsBody2D) -> void:
	queue_free()

func enable() -> void:
	monitoring = true
	show()
