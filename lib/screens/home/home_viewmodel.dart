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

  List<Task> tasks = [];
  Task? newTask;

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
    tasks[index].isDone = !tasks[index].isDone!;
    notifyListeners();
  }

  addTask(String task) async {
    taskDataLoading = true;
    tasks.add(
      Task(userId: _authService.userProfile.id, task: task, isDone: false),
    );
    print("Adding task User Id: ${_authService.userProfile.id}");
    newTask = Task(
      userId: _authService.userProfile.id,
      task: task,
      isDone: false,
    );
    await _dbService.addTask(newTask!);
    taskDataLoading = false;
    notifyListeners();
  }

  getTasks() async {
    taskDataLoading = true;
    tasks = await _dbService.getTasks(_authService.userProfile.id!);
    print('Tasks Length: ${tasks.length}');
    taskDataLoading = false;
    notifyListeners();
  }

  logout() async {
    await _authService.logout();
    print('Siging Out...');
    Get.to(() => SignInScreenOne());
  }
}
