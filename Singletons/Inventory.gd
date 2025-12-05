extends Node

signal inventory_changed

var items: Dictionary = {}

func add_item(type: String, amount: int = 1) -> void:
    if not items.has(type):
        items[type] = 0
    items[type] += amount
    inventory_changed.emit()

func remove_item(type: String, amount: int = 1) -> void:
    if not items.has(type):
        return
    items[type] -= amount
    if items[type] <= 0:
        items.erase(type)
    inventory_changed.emit()

func get_amount(type: String) -> int:
    return items.get(type, 0)

func get_items() -> Dictionary:
    return items
