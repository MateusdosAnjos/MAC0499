extends Control

#Keeps the item placed on ActionSpace
var placed_item = null
#Used to create a metric for item positioning
var grid = {}
#Size of each grid cell
var cell_size = 2
#Size of the grid
var grid_width = 0
var grid_height = 0
#The grid center, used to position the item
var grid_center = []
#Argument list to be passed when executing the item code (see RunEnvironment.gd)
var argument_list = []
#Used to know when ActionSpace already has an item placed
onready var exist_item = false

#_ready initializes the grid
func _ready():
    var s = get_grid_size(self)
    grid_width = s.x
    grid_height = s.y
    #Used to place the item in the center of Action Space
    grid_center = [grid_width/2, grid_height/2]
    
    for x in range (grid_width):
        grid[x] = {}
        for y in range (grid_height):
            grid[x][y] = false
            
#This function inserts the item on Action Space if it is possible
#returns true when it was possible to insert and false when it's not
func insert_item(item):
    var item_size = get_grid_size(item)
    var g_pos = {}
    #Always place in the center of Action Space
    g_pos.x = grid_center[0] - (item_size.x)/2
    g_pos.y = grid_center[1] - (item_size.y)/2
    if not exist_item:
        if is_grid_space_available(g_pos.x, g_pos.y, item_size.x, item_size.y):
            set_grid_space(g_pos.x, g_pos.y, item_size.x, item_size.y, true)
            item.rect_global_position = rect_global_position + Vector2(g_pos.x, g_pos.y) * cell_size
            placed_item = item
            exist_item = true
            show_message(false)
            return true
        else:
            return false
    else:
        return false        

#Receives a position(pos) and tries to grab the item under it
#returning the item if it was sucessfull or null when it's not
#(Each Action Space holds a maximum of 1 item, that's why it's THE
#item)
func grab_item(pos):
    var item = get_item_under_pos(pos)
    if item == null:
        return null            
    var item_pos = item.rect_global_position + Vector2(cell_size/2, cell_size/2)
    var g_pos = pos_to_grid_coord(item_pos)
    var item_size = get_grid_size(item)
    set_grid_space(g_pos.x, g_pos.y, item_size.x, item_size.y, false)
    placed_item = null
    exist_item = false
    show_message(true)
    return item

#Given a position (pos) returns the item under it or null when
#there is no item under it.
func get_item_under_pos(pos):
    if placed_item == null:
        return null
    if placed_item.get_global_rect().has_point(pos):
        return placed_item
    return null       

#Receives a (x, y) grid position and sets to
#state every position on the rectangle (x, x+w, y, y+h)
func set_grid_space (x, y, w, h, state):
        for i in range (x, x + w):
            for j in range (y, y + h):
                grid[i][j] = state

#Receives a rectangle with edges (x, y, x+w, y+h)
#and checks if there is space on the grid to position
#this rectangle
#Returns true if there is grid space and false if there is not
func is_grid_space_available(x, y, w, h):
    if x < 0 or y < 0:
        return false
    if x + w > grid_width or y + h > grid_height:
        return false
    for i in range (x, x + w):
        for j in range (y, y + h):
            if grid[i][j]:
                return false
    return true

#Receives a position (pos) and convert it to the
#grid coordenation system               
func pos_to_grid_coord(pos):
    var local_pos = pos - rect_global_position
    var results = {}
    results.x = int(local_pos.x / cell_size)
    results.y = int(local_pos.y / cell_size)
    return results

#Receives an item and return it's size (width and height) using
#the grid coordenation system             
func get_grid_size(item):
    var results = {}
    var s = item.rect_size
    results.x = clamp(int(s.x / cell_size), 1, 500)    
    results.y = clamp(int(s.y / cell_size), 1, 500)
    return results
                     
#Shows the name message ("Espaço de Ação")
#based on the boolean value 'state'
func show_message(state):
    var message = get_node("Name")
    if state:
        message.show()
    else:
        message.hide()
    return

#The signal passed when its time to fill argument_list
#variable
func _on_ArgumentButton_sent_arguments(arguments):
    argument_list = arguments
