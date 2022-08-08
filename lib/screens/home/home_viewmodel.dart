import 'package:intl/intl.dart';
import 'package:must_do/core/data/dummy_tasks.dart';
import 'package:must_do/core/locator.dart';
import 'package:must_do/core/models/base_model.dart';
import 'package:must_do/core/models/tasks/tasks_model.dart';
import 'package:must_do/core/services/database_services.dart';

class HomeViewModel extends BaseViewModel {
  final DateTime todaysDate = DateTime.now();
  DatabaseService _dbService = locator<DatabaseService>();
  bool taskDataLoading = false;

  List<Task> tasks = [];

  HomeViewModel() {
    getTasks();
  }

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
    dummyTasks[index].isDone = !dummyTasks[index].isDone!;
    notifyListeners();
  }

  addTask(String task) {
    dummyTasks.add(
      Task(task: task, isDone: false),
    );
    notifyListeners();
  }

  getTasks() async {
    taskDataLoading = true;
    tasks = await _dbService.getTasks();
    print('Tasks Length: ${tasks.length}');
    taskDataLoading = false;
    notifyListeners();
  }
}
