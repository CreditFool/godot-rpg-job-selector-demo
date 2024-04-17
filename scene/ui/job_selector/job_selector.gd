extends Control

@export var job_data_loader: CSVLoader
@export var job_list_option: OptionButton
@export var job_name_label: Label
@export var job_description_label: Label
@export var skill_list_container: BoxContainer

var class_data

func _ready():
	var jobname := {}
	for job in job_data_loader.data:
		jobname[int(job["ID"])] = job["JOBNAME"]
	update_job_list_option(jobname)
	update_job_information()


func update_job_list_option(items: Dictionary):
	job_list_option.clear()
	for id in items:
		job_list_option.add_item(items[id], id)


func update_job_name_label(job_name: String):
	job_name_label.text = job_name


func update_job_description_label(job_description: String):
	job_description_label.text = job_description


func update_skill_list_container(skill_list: Array):
	for child in skill_list_container.get_children():
		child.queue_free()

	for skill in skill_list:
		var skill_label = Label.new()
		skill_label.text = "- " + skill.trim_prefix(" ")
		skill_list_container.add_child(skill_label)


func update_job_information():
	var job_data = job_data_loader.data[job_list_option.selected]
	update_job_name_label(job_data["JOBNAME"])
	update_job_description_label(job_data["DESCRIPTION"])
	update_skill_list_container(job_data["SKILLS"].trim_suffix(";").split(";"))


func _on_job_list_option_item_selected(_index):
	update_job_information()
