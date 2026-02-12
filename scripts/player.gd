extends KinematicBody2D

# Player properties
var speed = 200
var jump_speed = -400
var gravity = 1000
var health = 100
var dashing = false
var dash_speed = 400
var dash_time = 0.3
var dash_cooldown = 0.5
var dash_duration = 0.2
var is_dashing = false
var dash_timer = 0
var cooldown_timer = 0
var attack_damage = 10

# State variables
var velocity = Vector2()
var can_dash = true
var can_attack = true

# Called every frame.\nfunc _process(delta):
    if cooldown_timer > 0:
        cooldown_timer -= delta
    if is_dashing:
        dash_timer -= delta
        if dash_timer <= 0:
            is_dashing = false
            velocity = Vector2()
    else:
        handle_movement(delta)
        handle_jump()
        handle_dash()
        if Input.is_action_just_pressed('attack'):
            perform_attack()
    move_and_slide(velocity)

# Handle player movement
func handle_movement(delta):
    velocity.x = 0
    if Input.is_action_pressed('move_right'):
        velocity.x += speed
    if Input.is_action_pressed('move_left'):
        velocity.x -= speed

# Handle jump action
func handle_jump():
    if is_on_floor() and Input.is_action_just_pressed('jump'):
        velocity.y = jump_speed

# Handle dashing mechanics
func handle_dash():
    if can_dash and Input.is_action_just_pressed('dash'):
        is_dashing = true
        dash_timer = dash_duration
        velocity.x = dash_speed * (Input.is_action_pressed('move_right') ? 1 : -1)
        cooldown_timer = dash_cooldown
        can_dash = false

# Perform an attack
func perform_attack():
    # Implement attack logic here
    pass

# Function to receive damage
func take_damage(amount):
    health -= amount
    if health <= 0:
        die()

# Function to handle player death
func die():
    queue_free()