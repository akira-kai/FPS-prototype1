extends CanvasLayer
class_name UI

var game_is_paused : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	game_is_paused = false
	self.hide()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel") and game_is_paused == false:
		GameMaster.pause_game(self)
		self.show()
		game_is_paused = true
		#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		print_debug("Game is paused is: ", game_is_paused)
		
	elif Input.is_action_just_pressed("ui_cancel") and game_is_paused == true:
		GameMaster.unpause_game(self)
		self.hide()
		game_is_paused = false
		#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		print_debug("Game is paused is: ", game_is_paused)
