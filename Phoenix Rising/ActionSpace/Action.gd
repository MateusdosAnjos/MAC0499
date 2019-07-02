extends TextureRect

signal entered_tree(nodeName)

var placedItem = null
var grid = {}
var cell_size = 2
var grid_width = 0
var grid_height = 0
var grid_center = []

onready var existItem = false
onready var helpPanel = get_node("helpPanel")

func _ready():
    emit_signal("entered_tree", get_name())
    var s = get_grid_size(self)
    grid_width = s.x
    grid_height = s.y
    #Used to place the item in the center of Action Space
    grid_center = [grid_width/2, grid_height/2]
    
    for x in range (grid_width):
        grid[x] = {}
        for y in range (grid_height):
            grid[x][y] = false
            
func insert_item(item):
    var item_pos = item.rect_global_position + Vector2(cell_size/2, cell_size/2)
    var item_size = get_grid_size(item)
    var g_pos = {}
    #Always place in the center of Action Space
    g_pos.x = grid_center[0] - (item_size.x)/2
    g_pos.y = grid_center[1] - (item_size.y)/2
    if not existItem:
        if is_grid_space_available(g_pos.x, g_pos.y, item_size.x, item_size.y):
            set_grid_space(g_pos.x, g_pos.y, item_size.x, item_size.y, true)
            item.rect_global_position = rect_global_position + Vector2(g_pos.x, g_pos.y) * cell_size
            placedItem = item
            existItem = true
            show_message(false)
            return true
        else:
            return false
    else:
        return false        

func grab_item(pos):
    var item = get_item_under_pos(pos)
    if item == null:
        return null            
    var item_pos = item.rect_global_position + Vector2(cell_size/2, cell_size/2)
    var g_pos = pos_to_grid_coord(item_pos)
    var item_size = get_grid_size(item)
    set_grid_space(g_pos.x, g_pos.y, item_size.x, item_size.y, false)
    placedItem = null
    existItem = false
    show_message(true)
    return item
        
func get_item_under_pos(pos):
    if placedItem.get_global_rect().has_point(pos):
        return placedItem
    return null       

func set_grid_space (x, y, w, h, state):
        for i in range (x, x + w):
            for j in range (y, y + h):
                grid[i][j] = state
                   
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
                                
func pos_to_grid_coord(pos):
    var local_pos = pos - rect_global_position
    var results = {}
    results.x = int(local_pos.x / cell_size)
    results.y = int(local_pos.y / cell_size)
    return results
                         
func get_grid_size(item):
    var results = {}
    var s = item.rect_size
    results.x = clamp(int(s.x / cell_size), 1, 500)    
    results.y = clamp(int(s.y / cell_size), 1, 500)
    return results
    
func insert_item_at_first_available_spot(item):
    for y in range (grid_height):
        for x in range (grid_width):
            if !grid[x][y]:
                item.rect_global_position = rect_global_position + Vector2(x, y) * cell_size
                if insert_item(item):
                    return true
    return false                        

func show_message(state):
    var message = get_node("HowToUse")
    if state:
        message.show()
    else:
        message.hide()
    return
    