import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:must_do/core/constants/text_styles.dart';
import 'package:must_do/screens/auth/signin/signin_screen_two.dart';
import 'package:must_do/screens/auth/signup/signup_screen1.dart';

class SignInScreenOne extends StatelessWidget {
  SignInScreenOne({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final status = await Get.dialog(AlertDialog(
          title: const Text('Caution'),
          content:
              const Text('Hey, are you sure you wanna close the application?'),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.black87),
              onPressed: () {
                exit(0);
              },
              child: const Text(
                'yes',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.black87),
              onPressed: () {
                Get.back(result: false);
              },
              child: const Text(
                'no',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ));

        return status;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 88.0.h),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Text(
                  'Lets enter to your tasks zone!',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade500,
                  ),
                ),
                SizedBox(height: 120.h),
                TextFormField(
                  autofocus: true,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Your email...',
                    hintStyle: kHintTextStyle,
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter valid email';
                    } else {
                      return null;
                    }
                  },
                  onFieldSubmitted: (value) {
                    if (_formKey.currentState!.validate()) {
                      Get.to(() => SignInScreenTwo(email: value));
                    }
                  },
                ),
                SizedBox(height: 30.h),
                GestureDetector(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'or Sign Up',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.to(() => SignUpScreenOne());
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
