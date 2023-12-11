extends Node
##	Save/load metadata.


@export var profile: String = "default"
@export var auto: bool = true

var metadata: Dictionary = {}


func _ready() -> void:
	check_for_save_directory()
	check_for_profile_directory(profile)

	if auto:
		load_meta()


func _exit_tree() -> void:
	if auto:
		save_meta()


func check_for_save_directory() -> void:
	var user_directory: DirAccess = DirAccess.open("user://")
	if not user_directory.dir_exists("saves"):
		user_directory.make_dir("saves")


func check_for_profile_directory(profile_name: String) -> void:
	var save_directory: DirAccess = DirAccess.open("user://saves")
	if not save_directory.dir_exists(profile_name):
		save_directory.make_dir(profile_name)


func save_meta() -> void:
	for metakey in get_parent().get_meta_list():
		metadata[metakey] = get_parent().get_meta(metakey)

	var file_path = "user://saves/" + profile + "/" + get_parent().name + ".dat"
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_var(metadata)


func load_meta() -> void:
	var file_path = "user://saves/" + profile + "/" + get_parent().name + ".dat"
	if FileAccess.file_exists(file_path):
		metadata = FileAccess.open(file_path, FileAccess.READ).get_var()

	for metakey in metadata:
		get_parent().set_meta(metakey, metadata[metakey])
