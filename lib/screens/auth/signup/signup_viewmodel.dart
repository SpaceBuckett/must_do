import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:must_do/core/locator.dart';
import 'package:must_do/core/models/base_model.dart';
import 'package:must_do/core/models/user/user_model.dart';
import 'package:must_do/core/services/auth_services.dart';
import 'package:must_do/core/services/custom_auth.dart';
import 'package:must_do/core/services/database_services.dart';
import 'package:must_do/screens/home/home_screen.dart';

class SignUpViewModel extends BaseViewModel {
  UserProfile userProfile = UserProfile();
  final _authService = locator<AuthService>();
  final _dbService = locator<DatabaseService>();
  late CustomAuthResult authResult;

  createUserAccount(String email, String password, String name) async {
    print('@CreateingUserAccount!');
    userProfile.email = email;
    userProfile.password = password;
    userProfile.name = name;

    authResult = await _authService.signUpWithEmailandPassword(userProfile);
    if (authResult.status == true) {
      userProfile.fcmToken = await FirebaseMessaging.instance.getToken();

      await _dbService.updateFcmToken(
          userProfile.fcmToken, authResult.user!.uid);
      print('Now heading to HomeScreen!!');

      Get.to(() => const HomeScreen());
    }
  }
}
