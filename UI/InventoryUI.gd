extends CanvasLayer

@onready var items_container: VBoxContainer = $PanelContainer/VBoxContainer/ItemsContainer

func _ready() -> void:
    Inventory.inventory_changed.connect(_refresh)
    _refresh()

func _refresh() -> void:
    for child in items_container.get_children():
        child.queue_free()

    var items := Inventory.get_items()
    for type in items.keys():
        var amount := items[type]
        var label := Label.new()
        label.text = "%s: %d" % [type.capitalize(), amount]
        items_container.add_child(label)
