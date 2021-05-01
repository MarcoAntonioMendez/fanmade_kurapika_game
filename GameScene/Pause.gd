extends Control

# This function is like a switch for pausing and unpausing the game
func pause_unpause_game():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state

func _input(event):
	if event.is_action_pressed("pause"):
		pause_unpause_game()

# When user touches the ContinueButton, the game is unpaused.
func _on_ContinueButton_pressed():
	pause_unpause_game()
