import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:must_do/core/models/user/user_model.dart';
import 'package:must_do/core/services/custom_auth.dart';
import 'package:must_do/core/services/database_services.dart';

class AuthService extends ChangeNotifier {
  final _dbService = DatabaseService();
  UserProfile userProfile = UserProfile();
  User? user;
  CustomAuthResult customAuthResult = CustomAuthResult();
  late bool isLogin = false;

  AuthService() {
    init();
  }

  init() async {
    print('@AuthService/init!!');
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      isLogin = true;
      user = FirebaseAuth.instance.currentUser;
      userProfile = await _dbService.getUser(user!.uid);
    } else {
      isLogin = false;
    }
  }

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
        isLogin = true;
        notifyListeners();
      } else {
        customAuthResult.status = false;
        isLogin = false;
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

  ///
  /// [Sign] with email and password
  ///
  Future<CustomAuthResult> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final credentials = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credentials.user != null) {
        userProfile = await _dbService.getUser(credentials.user!.uid);
        customAuthResult.status = true;
        customAuthResult.user = credentials.user;
        isLogin = true;
      } else {
        customAuthResult.status = false;
        customAuthResult.errorMessage =
            'Some unknown error occured while signing in';
      }
    } catch (e) {
      customAuthResult.status = false;
      print('Exception: $e');
    }

    return customAuthResult;
  }

  ///
  /// [Logout]
  ///
  logout() async {
    await FirebaseAuth.instance.signOut();
    isLogin = false;
  }
}
