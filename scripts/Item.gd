extends Area2D

export(String) var slot := "W"
export(Color) var color := Color(1, 1, 1)
var drop_time := 0
const PICKUP_DELAY := 5.0

func _ready():
    var sprite = Sprite.new()
    sprite.texture = _create_texture(color)
    sprite.centered = true
    add_child(sprite)
    var label = Label.new()
    label.text = slot
    label.align = Label.ALIGN_CENTER
    label.valign = Label.VALIGN_CENTER
    label.rect_position = Vector2(-8, -8)
    label.rect_size = Vector2(16, 16)
    add_child(label)
    var collision = CollisionShape2D.new()
    var shape = RectangleShape2D.new()
    shape.extents = Vector2(8, 8)
    collision.shape = shape
    add_child(collision)
    connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
    if OS.get_ticks_msec() - drop_time < int(PICKUP_DELAY * 1000):
        return
    if body.has_method("pickup_item"):
        body.pickup_item(self)

func _create_texture(color: Color):
    var img = Image.new()
    img.create(16, 16, false, Image.FORMAT_RGBA8)
    img.fill(color)
    var tex = ImageTexture.new()
    tex.create_from_image(img)
    return tex
