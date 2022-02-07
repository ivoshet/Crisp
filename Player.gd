extends Area2D
signal hit

export var speed = 400
var screen_size
var hero_size

func _ready():
	#получаем информацию о размере экрана при старте программы
	screen_size = get_viewport_rect().size
	#hide()
	
func _process(delta):
	var velocity = Vector2.ZERO 
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		#$AnimatedSprite.play()
		get_node("AnimatedSprite").play()
	else:
		$AnimatedSprite.stop()
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	if velocity.x != 0:
		get_node("AnimatedSprite").animation = "walk"
		get_node("AnimatedSprite").flip_v = false
		get_node("AnimatedSprite").flip_h = velocity.x < 0
	elif velocity.y != 0:
		get_node("AnimatedSprite").animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
	
func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	get_node("CollisionShape2D").disabled = false


