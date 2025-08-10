extends TileMap

const MAP_WIDTH = 128
const MAP_HEIGHT = 128
const TILE_SIZE = 16

const ITEM_SCENE = preload("res://scenes/Item.tscn")
const SLOTS = ["H", "B", "L", "A", "W"]
const QUALITY_COLORS = [
    Color(0.5, 0.5, 0.5), # Grey
    Color(0, 1, 0),       # Green
    Color(0, 0, 1),       # Blue
    Color(0.5, 0, 0.5),   # Purple
    Color(1, 0.84, 0)     # Gold
]

func _ready():
    randomize()
    tile_set = _create_tile_set()
    _generate_map()
    _spawn_items()

func _create_tile_set():
    var ts = TileSet.new()
    # Grass tile (id 0)
    ts.create_tile(0)
    ts.tile_set_texture(0, _create_texture(Color(0.2, 0.8, 0.2)))
    ts.tile_set_region(0, Rect2(Vector2(), Vector2(TILE_SIZE, TILE_SIZE)))
    # Water tile (id 1)
    ts.create_tile(1)
    ts.tile_set_texture(1, _create_texture(Color(0.1, 0.4, 0.8)))
    ts.tile_set_region(1, Rect2(Vector2(), Vector2(TILE_SIZE, TILE_SIZE)))
    return ts

func _create_texture(color):
    var img = Image.new()
    img.create(TILE_SIZE, TILE_SIZE, false, Image.FORMAT_RGBA8)
    img.fill(color)
    var tex = ImageTexture.new()
    tex.create_from_image(img)
    return tex

func _generate_map():
    var noise = OpenSimplexNoise.new()
    noise.seed = randi()
    noise.octaves = 4
    noise.period = 20.0
    noise.persistence = 0.8

    for x in range(MAP_WIDTH):
        for y in range(MAP_HEIGHT):
            var n = noise.get_noise_2d(x, y)
            var tile_id = 0
            if n <= 0.0:
                tile_id = 1
            set_cellv(Vector2(x, y), tile_id)

func _spawn_items():
    for slot in SLOTS:
        var item = ITEM_SCENE.instance()
        item.slot = slot
        item.color = QUALITY_COLORS[randi() % QUALITY_COLORS.size()]
        item.position = Vector2(
            randi() % (MAP_WIDTH * TILE_SIZE),
            randi() % (MAP_HEIGHT * TILE_SIZE)
        )
        add_child(item)
