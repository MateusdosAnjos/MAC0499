extends Node

var level_done = []
var current_level = 0
var total_points = 0
var total_levels = 9

func _ready():
    for i in range (9):
        level_done.append(false)
