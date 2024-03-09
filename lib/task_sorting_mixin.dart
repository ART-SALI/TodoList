import 'package:project2/task.dart';

mixin TaskSortingMixin {
  void sortByPriority(List<Task> tasks) {
    tasks.sort((a, b) => a.title.compareTo(b.title));
  }
}