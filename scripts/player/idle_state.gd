extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D


func _on_process(_delta: float) -> void:
    pass

func _on_physics_process(_delta: float) -> void:
    animated_sprite_2d.play("idle")
    if player.player_direction.x > 0:
        animated_sprite_2d.flip_h = false
    elif player.player_direction.x < 0:
        animated_sprite_2d.flip_h = true
    pass

func _on_next_transitions() -> void:
    GameInputEvents.movement_input()
    GameInputEvents.tool_input()

    if GameInputEvents.is_movement_input():
        transition.emit('Walk')
        
    if GameInputEvents.use_tool() \
     && player.current_tool == DataTypes.Tools.Axe:
        transition.emit('Axe')
        
    if GameInputEvents.use_tool() \
    && player.current_tool == DataTypes.Tools.Water:
        transition.emit('Water')
    pass
    
    if GameInputEvents.use_tool() \
    && player.current_tool == DataTypes.Tools.Pickaxe:
        transition.emit('Pickaxe')
    pass
    
    if GameInputEvents.use_tool() \
    && player.current_tool == DataTypes.Tools.Shovel:
        transition.emit('Dig')
    pass

    if GameInputEvents.use_tool() \
    && player.current_tool == DataTypes.Tools.Corn:
        transition.emit('Plant')
    pass


func _on_enter() -> void:
    pass


func _on_exit() -> void:
    pass
