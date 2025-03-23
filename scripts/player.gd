extends CharacterBody2D

# Variabel kecepatan gerakan player
const SPEED = 150.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

# Menghandle fisika dan pergerakan player
func _physics_process(delta: float) -> void:
    # Mendapatkan arah gerakan berdasarkan input
    var direction = Vector2.ZERO
    
    if Input.is_action_pressed("left"):
        direction.x -= 1
    if Input.is_action_pressed("right"):
        direction.x += 1
    if Input.is_action_pressed("up"):
        direction.y -= 1
    if Input.is_action_pressed("down"):
        direction.y += 1
    
    # Normalisasi vektor arah untuk gerakan diagonal yang konsisten
    if direction.length() > 0:
        direction = direction.normalized()
        # Mainkan animasi berjalan
        $AnimatedSprite2D.play("walk")
        
        # Mengatur arah menghadap sprite
        if direction.x != 0:
            $AnimatedSprite2D.flip_h = direction.x < 0
    else:
        # Mainkan animasi idle saat tidak bergerak
        $AnimatedSprite2D.play("default")
    
    # Set velocity berdasarkan arah dan kecepatan
    velocity = direction * SPEED
    
    # Gerakkan karakter
    move_and_slide()
