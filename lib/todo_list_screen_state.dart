import 'package:flutter/material.dart';
import 'package:project2/task.dart';
import 'package:project2/task_sorting_mixin.dart';
import 'package:project2/tasks.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> with TaskSortingMixin {

  List<Task> helloList = [Task(title: 'HELLO', description: 'this is todo list')];

  Tasks? taskList;

  @override
  Widget build(BuildContext context) {
    taskList ??= Tasks([...helloList]);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
        ),
        body: ListView.builder(
          itemCount: taskList!.length(),
          itemBuilder: (context, index) {
            return ListTile(
              onTap: (){
                _showTaskDialogOfChangeTask(taskList!.getTask(index));
              },
              title: Text(taskList!.getTask(index).title),
              subtitle: Text(taskList!.getTask(index).description),
              trailing: Checkbox(
                value: taskList!.getTask(index).isCompleted,
                onChanged: (value) {
                  setState(() {
                    taskList!.getTask(index).isCompleted = value!;
                  });
                },
              ),
            );
          },
        ),
        floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  _showTaskDialogOfAdding();
                },
                child: const Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    sortByPriority(taskList!.tasks);
                  });
                },
                child: const Icon(Icons.sort),
              ),
              FloatingActionButton(
                onPressed: () {
                  _showTaskDialogOfRemoving();
                },
                child: const Icon(Icons.remove),
              ),
            ]
        )
    );
  }

  void _showTaskDialogOfAdding() {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  taskList!.addTask(
                    Task(
                      title: titleController.text,
                      description: descriptionController.text.isEmpty? 'no description':descriptionController.text,
                    ),
                  );
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showTaskDialogOfChangeTask(Task task) {
    TextEditingController descriptionController = TextEditingController(text: task.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Description To The Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                task.title
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description to add'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                var taskChenger = sameTask(
                    Task.withEmptybleDescription(task.title, descriptionController.text,)
                );
                setState(() {
                  taskChenger(taskList!.tasks);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save change'),
            ),
          ],
        );
      },
    );
  }


  void _showTaskDialogOfRemoving() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Remove completed tasks'),
          content: const Text(
            'Do you want to remove all completed tasks?',
            style: TextStyle(
                fontSize: 18
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  taskList!.deleteCompletedTask();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

}

Function sameTask(Task task){
  assert(task.title.isNotEmpty, 'Task title must not be empty');
  assert(task.description.isNotEmpty, 'Task description must not be empty');
  return (List<Task> allTasks) => allTasks.forEach((element) {
    if(element == task){
      element.description = task.description;
    }
  });
}


