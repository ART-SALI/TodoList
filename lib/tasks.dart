import 'package:project2/task.dart';

class Tasks {
  List<Task> tasks = [];

  Tasks(this.tasks);

  int length(){
    return tasks.length;
  }

  Task getTask(int index){
    return tasks[index];
  }

  void addTask(Task task) {
    assert(task.title.isNotEmpty, 'Task title must not be empty');
      tasks.add(task);
  }

  void deleteCompletedTask() {
      tasks.removeWhere((task) => task.isCompleted);
  }
}