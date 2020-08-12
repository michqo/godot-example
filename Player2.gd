extends KinematicBody2D

var speed = 350
var velocity = Vector2()
var minDistance = 100

func get_input():
	look_at(get_global_mouse_position())
	velocity.x = lerp(velocity.x, 0, 0.3)
	velocity.y = lerp(velocity.y, 0, 0.3)
	if Input.is_action_pressed("ui_select"):
		#if position.distance_to(get_global_mouse_position()) >= 100:
		velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
