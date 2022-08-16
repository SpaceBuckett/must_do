import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:must_do/core/constants/text_styles.dart';
import 'package:must_do/screens/auth/signup/signup_viewmodel.dart';
import 'package:provider/provider.dart';

class SignUpScreenThree extends StatelessWidget {
  final String? email, password;
  SignUpScreenThree({required this.email, required this.password, Key? key})
      : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
      child: Consumer<SignUpViewModel>(
        builder: (context, model, child) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 88.0, right: 30),
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Text(
                    'What would you loved to be called?',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(height: 120.sp),
                  TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.done,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: 'your name...',
                      hintStyle: kHintTextStyle,
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter valid name!';
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (value) {
                      if (_formKey.currentState!.validate()) {
                        // Get.to(() => SignUpScreen());
                        model.createUserAccount(email!, password!, value);
                      }
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
