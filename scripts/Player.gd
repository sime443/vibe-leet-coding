extends KinematicBody2D

export var speed := 100
var BulletScene = preload("res://scenes/Bullet.tscn")

func _ready():
    var sprite = Sprite.new()
    sprite.texture = _create_texture(Color(1, 0, 0))
    sprite.centered = true
    add_child(sprite)
    var collision = CollisionShape2D.new()
    var shape = RectangleShape2D.new()
    shape.extents = Vector2(8, 8)
    collision.shape = shape
    add_child(collision)

func _physics_process(delta):
    var input_vector = Vector2(
        Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
        Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
    )
    if input_vector.length() > 0:
        input_vector = input_vector.normalized()
    move_and_slide(input_vector * speed)
    if Input.is_action_just_pressed("shoot"):
        shoot()

func shoot():
    var bullet = BulletScene.instance()
    bullet.position = global_position
    bullet.direction = (get_global_mouse_position() - global_position).normalized()
    get_parent().add_child(bullet)

func _create_texture(color: Color):
    var img = Image.new()
    img.create(16, 16, false, Image.FORMAT_RGBA8)
    img.fill(color)
    var tex = ImageTexture.new()
    tex.create_from_image(img)
    return tex
