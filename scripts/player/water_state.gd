extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D

func _on_process(_delta : float) -> void:
    pass


func _on_physics_process(_delta : float) -> void:
    pass


func _on_next_transitions() -> void:
    GameInputEvents.tool_input()
    if !animated_sprite_2d.is_playing():
        transition.emit("Idle")
    pass


func _on_enter() -> void:
    animated_sprite_2d.play("water")
    pass


func _on_exit() -> void:
    animated_sprite_2d.stop()
    pass
