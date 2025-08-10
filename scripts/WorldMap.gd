extends TileMap

const MAP_WIDTH: int = 128
const MAP_HEIGHT: int = 128
const TILE_SIZE: int = 16

const ITEM_SCENE: PackedScene = preload("res://scenes/Item.tscn")
const SLOTS := ["H", "B", "L", "A", "W"]
const QUALITY_COLORS := [
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
    var grass = TileSetAtlasSource.new()
    grass.texture = _create_texture(Color(0.2, 0.8, 0.2))
    grass.create_tile(Vector2i(0, 0))
    ts.add_source(grass, 0)
    var water = TileSetAtlasSource.new()
    water.texture = _create_texture(Color(0.1, 0.4, 0.8))
    water.create_tile(Vector2i(0, 0))
    ts.add_source(water, 1)
    return ts

func _create_texture(color):
    var img = Image.create(TILE_SIZE, TILE_SIZE, false, Image.FORMAT_RGBA8)
    img.fill(color)
    var tex = ImageTexture.new()
    tex.set_image(img)
    return tex

func _generate_map():
    var noise = FastNoiseLite.new()
    noise.seed = randi()
    noise.frequency = 1.0 / 20.0
    noise.fractal_octaves = 4
    noise.fractal_gain = 0.8

    for x in range(MAP_WIDTH):
        for y in range(MAP_HEIGHT):
            var n = noise.get_noise_2d(x, y)
            var tile_id = 0
            if n <= 0.0:
                tile_id = 1
            set_cell(0, Vector2i(x, y), tile_id, Vector2i(0, 0))

func _spawn_items():
    for slot in SLOTS:
        var item = ITEM_SCENE.instantiate()
        item.slot = slot
        item.color = QUALITY_COLORS[randi() % QUALITY_COLORS.size()]
        item.position = Vector2(
            randi() % (MAP_WIDTH * TILE_SIZE),
            randi() % (MAP_HEIGHT * TILE_SIZE)
        )
        add_child(item)
