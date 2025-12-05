extends Node2D

@onready var world: Node2D = $World
@onready var player: CharacterBody2D = $Player

func _ready() -> void:
    var spawn := world.get_node("PlayerSpawn")
    if spawn:
        player.position = spawn.global_position
