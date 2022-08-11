import 'package:flutter/material.dart';

class SignUpScreenThree extends StatelessWidget {
  final String? email, password;
  SignUpScreenThree({required this.email, required this.password, Key? key})
      : super(key: key);

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
                'What would you loved to be called?',
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
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
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
