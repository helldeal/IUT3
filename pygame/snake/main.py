import pygame
import sys
import random

# Initialize Pygame
pygame.init()

# Set up the display
window_size = (600, 600)
screen = pygame.display.set_mode(window_size)
pygame.display.set_caption('Snake Game')

# Colors
BLACK = (0, 0, 0)
WHITE = (255, 255, 255)
RED = (255, 0, 0)
GREEN = (0, 255, 0)

# Snake and food settings
snake_pos = [100, 60]
snake_body = [[100, 60], [100, 60], [80, 60]]
food_pos = [random.randrange(1, (window_size[0]//20)) * 20, random.randrange(1, (window_size[1]//20)) * 20]
food_spawn = True
direction = 'RIGHT'
change_to = direction

# Game variables
score = 0
speed = 15  
clock = pygame.time.Clock()

# Game over function
def display_score():
    my_font = pygame.font.SysFont('times new roman', 20)
    game_over_surface = my_font.render('Score : ' + str(score), True, WHITE)
    game_over_rect = game_over_surface.get_rect()
    game_over_rect.topleft = (20, 20)
    screen.blit(game_over_surface, game_over_rect)

def game_over():
    my_font = pygame.font.SysFont('times new roman', 50)
    game_over_surface = my_font.render('Your Score is: ' + str(score), True, RED)
    game_over_rect = game_over_surface.get_rect()
    game_over_rect.midtop = (window_size[0] / 2, window_size[1] / 4)
    screen.fill(BLACK)
    screen.blit(game_over_surface, game_over_rect)
    pygame.display.flip()
    pygame.time.wait(3000)
    pygame.quit()
    sys.exit()

# Main game loop
while True:
    for event in pygame.event.get():
        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_UP:
                change_to = 'UP'
            elif event.key == pygame.K_DOWN:
                change_to = 'DOWN'
            elif event.key == pygame.K_LEFT:
                change_to = 'LEFT'
            elif event.key == pygame.K_RIGHT:
                change_to = 'RIGHT'

    # Validate direction
    if change_to == 'UP' and direction != 'DOWN':
        direction = 'UP'
    if change_to == 'DOWN' and direction != 'UP':
        direction = 'DOWN'
    if change_to == 'LEFT' and direction != 'RIGHT':
        direction = 'LEFT'
    if change_to == 'RIGHT' and direction != 'LEFT':
        direction = 'RIGHT'

    # Move the snake
    if direction == 'UP':
        snake_pos[1] -= 20
    if direction == 'DOWN':
        snake_pos[1] += 20
    if direction == 'LEFT':
        snake_pos[0] -= 20
    if direction == 'RIGHT':
        snake_pos[0] += 20

    # Snake body growing mechanism
    snake_body.insert(0, list(snake_pos))
    if snake_pos == food_pos:
        score += 1
        food_spawn = False
    else:
        snake_body.pop()

    # Food spawn
    if not food_spawn:
        food_pos = [random.randrange(1, (window_size[0]//20)) * 20, random.randrange(1, (window_size[1]//20)) * 20]
    food_spawn = True

    # GFX
    screen.fill(BLACK)
    for pos in snake_body:
        pygame.draw.rect(screen, GREEN, pygame.Rect(pos[0], pos[1], 20, 20))

    pygame.draw.rect(screen, WHITE, pygame.Rect(food_pos[0], food_pos[1], 20, 20))

    # Game Over conditions
    if snake_pos[0] < 0 or snake_pos[0] > window_size[0]-20:
        game_over()
    if snake_pos[1] < 0 or snake_pos[1] > window_size[1]-20:
        game_over()
    for block in snake_body[1:]:
        if snake_pos == block:
            game_over()
    
    display_score()

    # Update screen and set game speed
    pygame.display.update()
    clock.tick(speed)
