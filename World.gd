extends Node2D

@onready var ground: TileMap = $Ground
@onready var resource_container: Node2D = $ResourceContainer
@onready var player_spawn: Marker2D = $PlayerSpawn

@export var map_width: int = 64
@export var map_height: int = 64
@export var island_radius: int = 20
@export var water_tile_id: int = 0
@export var grass_tile_id: int = 1

var _rng := RandomNumberGenerator.new()

func _ready() -> void:
    _rng.randomize()
    _generate_island()
    _spawn_resources()

func _generate_island() -> void:
    ground.clear()
    var center := Vector2i(map_width / 2, map_height / 2)

    for x in range(map_width):
        for y in range(map_height):
            var pos := Vector2i(x, y)
            var dist := pos.distance_to(center)

            if dist < float(island_radius):
                ground.set_cell(0, pos, grass_tile_id, Vector2i.ZERO)
            else:
                ground.set_cell(0, pos, water_tile_id, Vector2i.ZERO)

    var world_center := ground.map_to_local(center)
    player_spawn.position = world_center

func _spawn_resources() -> void:
    var center := Vector2i(map_width / 2, map_height / 2)

    for i in range(30):
        var angle := _rng.randf_range(0.0, TAU)
        var radius := _rng.randi_range(3, island_radius - 2)
        var pos := center + Vector2i(
            int(radius * cos(angle)),
            int(radius * sin(angle))
        )

        if ground.get_cell_source_id(0, pos) == grass_tile_id:
            var world_pos := ground.map_to_local(pos)
            _spawn_resource_at(world_pos)

func _spawn_resource_at(world_pos: Vector2) -> void:
    var res_scene: PackedScene = preload("res://ResourceNode.tscn")
    var instance: Area2D = res_scene.instantiate()
    instance.position = world_pos

    if _rng.randi() % 2 == 0:
        instance.resource_type = "wood"
    else:
        instance.resource_type = "stone"

    resource_container.add_child(instance)
