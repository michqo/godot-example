extends KinematicBody2D

var velocity = Vector2()
var moveSpeed = 350
var fallSpeed = 30
#var fallSpeed = 70 - looks like bhop
var jumpSpeed = 750
var flyingSpeed = 90
var maxFlyingSpeed = 1200

var square = preload("res://Square.tscn")
var squares = []
var explosion = preload("res://Explosion.tscn")
var explosions = []

func _process(delta):
	if explosions.size() > 1000:
		for i in range(100):
			explosions.pop_front()

func _physics_process(delta):
	velocity.x = lerp(velocity.x, 0, 0.3)
	#velocity.x = lerp(velocity.x, 0, 0.1) - fun mode

	if Input.is_action_pressed("ui_left"):
		velocity.x -= moveSpeed
	if Input.is_action_pressed("ui_right"):
		velocity.x += moveSpeed
	if Input.is_action_pressed("ui_left_click"):
		if velocity.y - flyingSpeed > -maxFlyingSpeed:
			velocity.y -= flyingSpeed
	if Input.is_action_pressed("ui_right_click"):
		fallSpeed = 180
	if Input.is_action_pressed("ui_middle_click"):
		squares.append(square.instance())
		squares.back().position = Vector2(position.x, position.y - 100)
		get_tree().get_root().add_child(squares.back())
	if Input.is_action_pressed("ui_backspace"):
		if squares.size() > 0:
			explosions.append(explosion.instance())
			explosions.back().position = squares.back().position
			explosions.back().one_shot = true
			get_tree().get_root().add_child(explosions.back())
			squares.back().queue_free()
			squares.pop_back()
	if is_on_floor():
		if Input.is_action_pressed("ui_select"):
			velocity.y -= jumpSpeed
	else:
		velocity.y += fallSpeed
			
	fallSpeed = 30
	velocity = move_and_slide(velocity, Vector2(0, -1))
