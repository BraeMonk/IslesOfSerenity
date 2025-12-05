extends Area2D

@export var resource_type: String = "wood"
@export var amount: int = 3

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
    add_to_group("resource_node")

func harvest() -> void:
    if amount <= 0:
        return
    Inventory.add_item(resource_type, 1)
    amount -= 1

    if amount <= 0:
        queue_free()
