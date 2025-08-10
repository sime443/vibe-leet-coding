extends KinematicBody2D

export var speed := 100
var BulletScene = preload("res://scenes/Bullet.tscn")

const SLOT_OFFSETS = {
    "H": Vector2(0, -16),
    "B": Vector2(0, 0),
    "L": Vector2(0, 16),
    "A": Vector2(-16, 0),
    "W": Vector2(16, 0)
}

const SLOT_CAPACITY := 5
const BACKPACK_CAPACITY := 5

var equipment_sprites := {}
var equipped_items := {}
var inventory := {}
var backpack := []

func _ready():
    for slot in SLOT_OFFSETS.keys():
        var sprite = Sprite.new()
        sprite.texture = _create_texture(Color(0.5, 0.5, 0.5))
        sprite.position = SLOT_OFFSETS[slot]
        sprite.centered = true
        add_child(sprite)
        equipment_sprites[slot] = sprite
        equipped_items[slot] = null
        inventory[slot] = []
    var collision = CollisionShape2D.new()
    var shape = RectangleShape2D.new()
    shape.extents = Vector2(8, 8)
    collision.shape = shape
    add_child(collision)

func pickup_item(item):
    var data = {"slot": item.slot, "color": item.color}
    var slot = data.slot
    if equipped_items[slot] == null:
        _equip_data(data)
        item.queue_free()
    elif inventory[slot].size() < SLOT_CAPACITY:
        inventory[slot].append(data)
        item.queue_free()
    elif backpack.size() < BACKPACK_CAPACITY:
        backpack.append(data)
        item.queue_free()

func equip_from_inventory(slot, index):
    if inventory.has(slot) and index >= 0 and index < inventory[slot].size():
        var data = inventory[slot].remove(index)
        if equipped_items[slot] != null:
            _store_or_drop(equipped_items[slot])
        _equip_data(data)

func equip_from_backpack(index, slot):
    if index >= 0 and index < backpack.size():
        var data = backpack[index]
        if data.slot == slot:
            backpack.remove(index)
            if equipped_items[slot] != null:
                _store_or_drop(equipped_items[slot])
            _equip_data(data)

func drop_equipped(slot):
    if equipped_items.has(slot) and equipped_items[slot] != null:
        var data = equipped_items[slot]
        equipped_items[slot] = null
        equipment_sprites[slot].texture = _create_texture(Color(0.5, 0.5, 0.5))
        _drop_data(data)

func drop_from_inventory(slot, index):
    if inventory.has(slot) and index >= 0 and index < inventory[slot].size():
        var data = inventory[slot].remove(index)
        _drop_data(data)

func drop_from_backpack(index):
    if index >= 0 and index < backpack.size():
        var data = backpack.remove(index)
        _drop_data(data)

func _store_or_drop(data):
    var slot = data.slot
    if inventory[slot].size() < SLOT_CAPACITY:
        inventory[slot].append(data)
    elif backpack.size() < BACKPACK_CAPACITY:
        backpack.append(data)
    else:
        _drop_data(data)

func _equip_data(data):
    var slot = data.slot
    equipped_items[slot] = data
    equipment_sprites[slot].texture = _create_texture(data.color)

func _drop_data(data):
    var scene = preload("res://scenes/Item.tscn")
    var item = scene.instance()
    item.slot = data.slot
    item.color = data.color
    item.drop_time = OS.get_ticks_msec()
    item.position = global_position
    get_parent().add_child(item)

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
