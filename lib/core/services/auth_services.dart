import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:must_do/core/models/user/user_model.dart';
import 'package:must_do/core/services/custom_auth.dart';
import 'package:must_do/core/services/database_services.dart';

class AuthService extends ChangeNotifier {
  final _dbService = DatabaseService();
  UserProfile userProfile = UserProfile();
  CustomAuthResult customAuthResult = CustomAuthResult();

  late bool isLogin;

  Future<CustomAuthResult> signUpWithEmailandPassword(
      UserProfile userProfile) async {
    try {
      final credentials =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userProfile.email!,
        password: userProfile.password!,
      );
      if (credentials.user != null) {
        customAuthResult.status = true;
        customAuthResult.user = credentials.user;
        userProfile.id = credentials.user!.uid;
        await _dbService.registerUser(userProfile);
        this.userProfile = userProfile;
        notifyListeners();
      } else {
        customAuthResult.status = false;
        return customAuthResult;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (error, stacktrace) {
      print('Error: $error\nStacktrace: $stacktrace');
    }
    return customAuthResult;
  }
}
