extends Area2D

@export var slot: String = "W"
@export var color: Color = Color(1, 1, 1)
var drop_time: int = 0
const PICKUP_DELAY: float = 5.0

func _ready():
    var sprite = Sprite2D.new()
    sprite.texture = _create_texture(color)
    sprite.centered = true
    add_child(sprite)
    var label = Label.new()
    label.text = slot
    label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
    label.position = Vector2(-8, -8)
    label.size = Vector2(16, 16)
    add_child(label)
    var collision = CollisionShape2D.new()
    var shape = RectangleShape2D.new()
    shape.extents = Vector2(8, 8)
    collision.shape = shape
    add_child(collision)
    body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
    if Time.get_ticks_msec() - drop_time < int(PICKUP_DELAY * 1000):
        return
    if body.has_method("pickup_item"):
        body.pickup_item(self)

func _create_texture(color: Color):
    var img = Image.create(16, 16, false, Image.FORMAT_RGBA8)
    img.fill(color)
    var tex = ImageTexture.new()
    tex.set_image(img)
    return tex
