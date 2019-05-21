extends Panel

var PosX
var PosY
var SizeX
var SizeY

func _ready():
    PosX = rect_position.x
    PosY = rect_position.y
    SizeX = rect_size[0]
    SizeY = rect_size[1]
     
func _input(event):
    if help_area(event):
        print("OPA")

func has_item():
    return true
    
func help_area(event):
    var MousePos = get_global_mouse_position()
    if event is InputEventMouseMotion:
        if MousePos.x > PosX and MousePos.x < PosX + SizeX and MousePos.y > PosY and MousePos.y < PosY + SizeY:
            if has_item():
                return true
    return false
   
           
    