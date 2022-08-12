import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:must_do/core/constants/text_styles.dart';
import 'package:must_do/screens/auth/signup/signup_screen3.dart';

class SignUpScreenTwo extends StatelessWidget {
  final String? email;
  SignUpScreenTwo({required this.email, Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 88.0, right: 30),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                'Lets strengthen your account with a strong password!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(height: 120),
              TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.done,
                obscureText: true,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: '*******',
                  hintStyle: kHintTextStyle,
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter valid password!';
                  } else {
                    return null;
                  }
                },
                onFieldSubmitted: (value) {
                  if (_formKey.currentState!.validate()) {
                    Get.to(() => SignUpScreenThree(
                          email: email,
                          password: value,
                        ));
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
