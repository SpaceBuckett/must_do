import 'package:intl/intl.dart';
import 'package:must_do/core/data/dummy_tasks.dart';
import 'package:must_do/core/models/base_model.dart';
import 'package:must_do/core/models/tasks/tasks_model.dart';

class HomeViewModel extends BaseViewModel {
  final DateTime todaysDate = DateTime.now();

  weekday(DateTime date) {
    return DateFormat.EEEE().format(date).toString();
  }

  month(DateTime date) {
    return DateFormat.MMMM().format(date).toString();
  }

  monthDay(DateTime date) {
    return DateFormat.d().format(date).toString();
  }

  toggleTask(index) {
    dummyTasks[index].isDone = !dummyTasks[index].isDone;
    notifyListeners();
  }

  addTask(String task) {
    dummyTasks.add(
      Task(task: task, isDone: false),
    );
    notifyListeners();
  }
}
