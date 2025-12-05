extends CharacterBody2D

@export var move_speed: float = 150.0

@onready var interact_area: Area2D = $InteractArea
var _interact_target: Node = null

func _ready() -> void:
    interact_area.area_entered.connect(_on_area_entered)
    interact_area.area_exited.connect(_on_area_exited)

func _physics_process(delta: float) -> void:
    _handle_movement(delta)

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("interact"):
        _try_interact()

func _handle_movement(delta: float) -> void:
    var input_vector := Vector2(
        Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
        Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
    )

    if input_vector.length() > 0.0:
        input_vector = input_vector.normalized()
        velocity = input_vector * move_speed
        _update_sprite_direction(input_vector)
    else:
        velocity = Vector2.ZERO

    move_and_slide()

func _update_sprite_direction(dir: Vector2) -> void:
    if dir.x != 0.0:
        $Sprite2D.flip_h = dir.x < 0.0

func _on_area_entered(area: Area2D) -> void:
    if area.is_in_group("resource_node"):
        _interact_target = area

func _on_area_exited(area: Area2D) -> void:
    if area == _interact_target:
        _interact_target = null

func _try_interact() -> void:
    if _interact_target and _interact_target.has_method("harvest"):
        _interact_target.harvest()
