extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int = 6500

func _on_process(_delta : float) -> void:
    pass

func _on_physics_process(_delta : float) -> void:
    var direction: Vector2 = GameInputEvents.movement_input()
    
    animated_sprite_2d.play("walk")
    if direction.x > 0:
        animated_sprite_2d.flip_h = false
    elif direction.x < 0:
        animated_sprite_2d.flip_h = true
        
    if direction != Vector2.ZERO:
        player.player_direction = direction

    # normalize direction
    direction = direction.normalized()

    player.velocity = direction * speed * _delta
    player.move_and_slide()
    pass

func _on_next_transitions() -> void:
    GameInputEvents.tool_input()

    if !GameInputEvents.is_movement_input():
        transition.emit('Idle')
    
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
    
    pass


func _on_enter() -> void:
    pass


func _on_exit() -> void:
    pass
