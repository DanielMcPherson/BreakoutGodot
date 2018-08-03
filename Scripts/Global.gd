extends Node

# Game nodes. Scripts will self-report themselves so
# they will be accessible to other other scenes. 
var GameState
var Paddle
var Ball

# Number of bricks currently alive
var num_bricks = 0

# Scenes
var main_level = "res://Scenes/Level1.tscn"
var game_over = "res://Scenes/GameOver.tscn"