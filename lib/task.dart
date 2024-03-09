class Task {
  String title;
  String description;
  bool isCompleted;

  Task({required this.title, required this.description, this.isCompleted = false});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Task &&
              runtimeType == other.runtimeType &&
              title == other.title;

  @override
  int get hashCode => title.hashCode;

  factory Task.withEmptybleDescription(String titleOfTask,String descriptionOfTask){
    return Task(title: titleOfTask, description: descriptionOfTask.isEmpty? 'no description':descriptionOfTask);
  }

}