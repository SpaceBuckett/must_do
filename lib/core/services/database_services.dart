import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
      debugPrint('Error: $error\nStacktrace: $stacktrace');
    }
  }

  getUser(id) async {
    try {
      final snapshot = await _db.collection('users').doc(id).get();
      return UserProfile.fromJson(snapshot.data()!, snapshot.id);
    } catch (error) {
      debugPrint('Error: $error');
    }
  }

  Future<List<Task>> getCompletedTasks(String userId) async {
    List<Task> tasks = [];
    try {
      QuerySnapshot snapshot = await _db
          .collection('tasks')
          .where('userId', isEqualTo: userId)
          .where('isDone', isEqualTo: true)
          .get();
      if (snapshot.docs.isEmpty) {
        debugPrint('No Data Found');
      } else {
        for (int i = 0; i < snapshot.docs.length; i++) {
          tasks
              .add(Task.fromJson(snapshot.docs[i].data(), snapshot.docs[i].id));
        }
      }
    } catch (error) {
      debugPrint('Error: $error');
    }
    return tasks;
  }

  Future<List<Task>> getTasksToDo(String userId) async {
    List<Task> tasks = [];
    try {
      QuerySnapshot snapshot = await _db
          .collection('tasks')
          .where('userId', isEqualTo: userId)
          .where('isDone', isEqualTo: false)
          .get();
      if (snapshot.docs.isEmpty) {
        debugPrint('No Data Found');
      } else {
        for (int i = 0; i < snapshot.docs.length; i++) {
          tasks
              .add(Task.fromJson(snapshot.docs[i].data(), snapshot.docs[i].id));
        }
      }
    } catch (error) {
      debugPrint('Error: $error');
    }
    return tasks;
  }

  updateFcmToken(fcmToken, userId) async {
    await _db.collection('users').doc(userId).update({'fcmToke': fcmToken});
  }

  addTask(Task task) async {
    debugPrint('@Adding Task');
    try {
      await _db.collection('tasks').add(task.toJson());
      debugPrint('-- Task Added Successfully --');
    } catch (error) {
      debugPrint('Error: $error');
    }
  }

//   CollectionReference users = FirebaseFirestore.instance.collection('users');

// Future<void> updateUser() {
//   return users
//     .doc('ABC123')
//     .update({'info.address.zipcode': 90210})
//     .then((value) => print("User Updated"))
//     .catchError((error) => print("Failed to update user: $error"));
// }

  updateTask(bool isDone, taskId) async {
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

    await tasks.doc(taskId).update({'isDone': isDone});
    debugPrint('Task Updated Successfully with value $isDone');
  }

  Future<void> deleteTask(taskId) {
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    return tasks
        .doc(taskId)
        .delete()
        .then((value) => debugPrint("Task Deleted"))
        .catchError((error) => debugPrint("Failed to delete task: $error"));
  }
}
