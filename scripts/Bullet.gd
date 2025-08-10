extends Area2D

@export var speed: float = 400.0
var direction: Vector2 = Vector2.ZERO
var lifespan: float = 2.0

func _ready():
    var sprite = Sprite2D.new()
    sprite.texture = _create_texture(Color(1, 1, 0))
    sprite.centered = true
    add_child(sprite)
    var collision = CollisionShape2D.new()
    var shape = CircleShape2D.new()
    shape.radius = 4
    collision.shape = shape
    add_child(collision)

func _physics_process(delta):
    position += direction * speed * delta
    lifespan -= delta
    if lifespan <= 0:
        queue_free()

func _create_texture(color: Color):
    var img = Image.new()
    img.create(8, 8, false, Image.FORMAT_RGBA8)
    img.fill(color)
    return ImageTexture.create_from_image(img)
