extends Node
##	Automatically saves/loads metadata. 


const SAVEDATA_FOLDER: String = "user://SaveData/"

var metadata: Dictionary


func _ready() -> void:
	check_for_savedata_folder()
	load_metadata_from_file()


func _exit_tree() -> void:
	save_metadata_to_file()


func check_for_savedata_folder() -> void:
	var dir = DirAccess.open("user://")
	if not dir.dir_exists(SAVEDATA_FOLDER):
		dir.make_dir(SAVEDATA_FOLDER)


func save_metadata_to_file() -> void:
	# Read metadata
	var metalist = get_parent().get_meta_list()
	for metakey in metalist:
		metadata[metakey] = get_parent().get_meta(metakey)

	# Save metadata
	var path = SAVEDATA_FOLDER + get_parent().name + ".dat"
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_var(metadata)


func load_metadata_from_file() -> void:
	# Read metadata
	var path = SAVEDATA_FOLDER + get_parent().name + ".dat"
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		metadata = file.get_var()

		# Load metadata
		for metakey in metadata:
			get_parent().set_meta(metakey, metadata[metakey])
