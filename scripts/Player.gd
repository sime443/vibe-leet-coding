extends KinematicBody2D

export var speed := 100

const SLOT_OFFSETS = {
    "H": Vector2(0, -16),
    "B": Vector2(0, 0),
    "L": Vector2(0, 16),
    "A": Vector2(-16, 0),
    "W": Vector2(16, 0)
}

var equipment := {}

func _ready():
    for slot in SLOT_OFFSETS.keys():
        var sprite = Sprite.new()
        sprite.texture = _create_texture(Color(0.5, 0.5, 0.5))
        sprite.position = SLOT_OFFSETS[slot]
        sprite.centered = true
        add_child(sprite)
        equipment[slot] = sprite
    var collision = CollisionShape2D.new()
    var shape = RectangleShape2D.new()
    shape.extents = Vector2(8, 8)
    collision.shape = shape
    add_child(collision)

func equip_item(item):
    var slot = item.slot
    if equipment.has(slot):
        equipment[slot].texture = _create_texture(item.color)

func _physics_process(delta):
    var input_vector = Vector2(
        Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
        Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
    )
    if input_vector.length() > 0:
        input_vector = input_vector.normalized()
    move_and_slide(input_vector * speed)

func _create_texture(color: Color):
    var img = Image.new()
    img.create(16, 16, false, Image.FORMAT_RGBA8)
    img.fill(color)
    var tex = ImageTexture.new()
    tex.create_from_image(img)
    return tex
