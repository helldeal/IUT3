import pygame
import sys

# Initialize Pygame
pygame.init()

# Set up the display
window_size = (800, 600)
screen = pygame.display.set_mode(window_size)
pygame.display.set_caption('Game Menu')

# Colors
WHITE = (255, 255, 255)
GREEN = (0, 255, 0)
BLUE = (0, 0, 128)

# Font
font = pygame.font.Font(None, 36)

# Function to draw text
def draw_text(text, color, x, y):
    textobj = font.render(text, True, color)
    textrect = textobj.get_rect()
    textrect.topleft = (x, y)
    screen.blit(textobj, textrect)

# Main menu options
menu_options = ['Start Game', 'Options', 'High Scores', 'Exit']
option_rects = []

# Create rectangles for options
for i, option in enumerate(menu_options):
    option_rects.append(pygame.Rect(400, 150 + 50 * i, 200, 40))

# Main game loop
running = True
while running:
    screen.fill(WHITE)

    for i, option in enumerate(menu_options):
        pygame.draw.rect(screen, GREEN, option_rects[i])  # Draw button
        draw_text(option, BLUE, 400, 160 + 50 * i)  # Draw text

    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
        elif event.type == pygame.MOUSEBUTTONDOWN:
            mouse_pos = event.pos
            for i, rect in enumerate(option_rects):
                if rect.collidepoint(mouse_pos):
                    print(f"Clicked on {menu_options[i]}")  # Placeholder for actual functionality

    pygame.display.flip()

# Quit Pygame
pygame.quit()
sys.exit()
