import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:must_do/core/models/tasks/tasks_model.dart';
import 'package:must_do/core/models/user/user_model.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;

  registerUser(UserProfile userProfile) async {
    try {
      await _db
          .collection('users')
          .doc(userProfile.id)
          .set(userProfile.toJson());
    } catch (error, stacktrace) {
      print('Error: $error\nStacktrace: $stacktrace');
    }
  }

  getUser(id) async {
    try {
      final snapshot = await _db.collection('users').doc(id).get();
      return UserProfile.fromJson(snapshot.data()!, snapshot.id);
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<List<Task>> getTasks() async {
    List<Task> tasks = [];
    try {
      QuerySnapshot snapshot = await _db.collection('tasks').get();
      if (snapshot.docs.isEmpty) {
        print('No Data Found');
      } else {
        for (int i = 0; i < snapshot.docs.length; i++) {
          tasks
              .add(Task.fromJson(snapshot.docs[i].data(), snapshot.docs[i].id));
        }
      }
    } catch (error) {
      print('Error: $error');
    }
    return tasks;
  }

  updateFcmToken(fcmToken, userId) async {
    await _db.collection('users').doc(userId).update({'fcmToke': fcmToken});
  }

  addTask(Task task) async {
    print('@Adding Task');
    try {
      await _db.collection('tasks').add(task.toJson());
    } catch (error) {
      print('Error: $error');
    }
  }
}
