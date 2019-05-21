extends TextureRect

var items = []
var grid = {}

var existItem = false
var cell_size = 32
var grid_width = 0
var grid_height = 0

func _ready():
    var s = get_grid_size(self)
    grid_width = s.x
    grid_height = s.y
                     
func insert_item(item):  
    var item_pos = item.rect_global_position + Vector2(cell_size/2, cell_size/2)
    var g_pos = pos_to_grid_coord(item_pos)
    if not existItem:
        existItem = true
        item.rect_global_position = rect_global_position + Vector2(g_pos.x, g_pos.y) * cell_size
        items.append(item)
        return true
    else:
        return false

func grab_item(pos):
    var item = get_item_under_pos(pos)
    if item == null:
        return null            
    var item_pos = item.rect_global_position + Vector2(cell_size/2, cell_size/2)
    var g_pos = pos_to_grid_coord(item_pos)
    existItem = false
    items.remove(items.find(item))
    return item
        
func get_item_under_pos(pos):
    for item in items:
        if item.get_global_rect().has_point(pos):
            return item
    return null       
                              
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