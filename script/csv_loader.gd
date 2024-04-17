class_name CSVLoader
extends Node


@export_file var file_path: String
var data: Array


func _ready():
	data = read_csv(file_path)


func read_csv(path: String):
	var file = FileAccess.open(path, FileAccess.READ)

	var result := []
	var col_name = file.get_csv_line()
	
	while not file.eof_reached():
		var line := file.get_csv_line()
		var row = {}
		for i in range(len(col_name)):
			row[col_name[i]] = line[i] 
		result.append(row)
	file.close()

	return result
