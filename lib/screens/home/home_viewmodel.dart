import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:must_do/core/locator.dart';
import 'package:must_do/core/models/base_model.dart';
import 'package:must_do/core/models/tasks/tasks_model.dart';
import 'package:must_do/core/services/auth_services.dart';
import 'package:must_do/core/services/database_services.dart';
import 'package:must_do/screens/auth/signin/signin_screen_one.dart';

class HomeViewModel extends BaseViewModel {
  final DateTime todaysDate = DateTime.now();
  final DatabaseService _dbService = locator<DatabaseService>();
  bool taskDataLoading = false;
  final _authService = locator<AuthService>();

  List<Task> allTasks = [];
  List<Task> tasksTodo = [];
  List<Task> completedTasks = [];
  Task? newTask;
  bool showCompletedTasks = true;

  HomeViewModel() {
    debugPrint('@HomeViewModel');
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

  // toggleTask(index) {
  //   tasks[index].isDone = !tasks[index].isDone!;
  //   notifyListeners();
  // }

  addTask(String task) async {
    tasksTodo.add(
      Task(userId: _authService.userProfile.id, task: task, isDone: false),
    );
    notifyListeners();
    debugPrint("Adding task User Id: ${_authService.userProfile.id}");
    newTask = Task(
      userId: _authService.userProfile.id,
      task: task,
      isDone: false,
    );
    await _dbService.addTask(newTask!);
    notifyListeners();
  }

  getTasks() async {
    taskDataLoading = true;
    completedTasks =
        await _dbService.getCompletedTasks(_authService.userProfile.id!);
    tasksTodo = await _dbService.getTasksToDo(_authService.userProfile.id!);

    taskDataLoading = false;
    notifyListeners();
  }

  toggleIsDone(index, bool status, Task task) async {
    debugPrint('--------------------');
    debugPrint('Status: $status');
    debugPrint('--------------------');

    if (status == false) {
      tasksTodo[index].isDone = true;
      completedTasks.add(tasksTodo[index]);
      tasksTodo.removeAt(index);
      notifyListeners();
      await _dbService.updateTask(true, task.id);
    } else {
      completedTasks[index].isDone = false;
      tasksTodo.add(completedTasks[index]);
      completedTasks.removeAt(index);
      notifyListeners();
      await _dbService.updateTask(false, task.id);
    }
    // tasks[index].isDone = !tasks[index].isDone!;
    // _dbService.updateTask(tasks[index].isDone!, tasks[index].id);
    notifyListeners();
  }

  toggleTaskVisibility() {
    showCompletedTasks = !showCompletedTasks;
    notifyListeners();
  }

  removeTask(int index, bool status) async {
    if (status == false) {
      await _dbService.deleteTask(tasksTodo[index].id);
      tasksTodo.removeAt(index);
    }
  }

  logout() async {
    await _authService.logout();
    debugPrint('Siging Out...');
    Get.to(() => SignInScreenOne());
  }
}
