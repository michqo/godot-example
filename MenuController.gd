extends VBoxContainer

func newGame():
	get_tree().change_scene("res://World1.tscn")
	var fileRead = File.new()
	var fileWrite = File.new()
	# the file is by default read-only so you need to change that
	fileRead.open("user://info.txt", File.READ)
	if fileRead.file_exists("user://info.txt"):
		#print("File exists")
		var num = int(fileRead.get_as_text())
		num += 1
		fileWrite.open("user://info.txt", File.WRITE)
		fileWrite.store_string(str(num))
		print("The game has been started " + str(num) + " times")
	else:
		#print("File doesn't exist")
		fileWrite.open("user://info.txt", File.WRITE)
		fileWrite.store_string("1")
		print("The game has been started 1 time")
	fileRead.close()
	fileWrite.close()
