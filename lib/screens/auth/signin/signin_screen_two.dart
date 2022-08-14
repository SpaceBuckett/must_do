import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:must_do/core/constants/text_styles.dart';
import 'package:must_do/screens/auth/signin/signin_viewmodel.dart';
import 'package:must_do/screens/auth/signup/signup_screen3.dart';
import 'package:provider/provider.dart';

class SignInScreenTwo extends StatelessWidget {
  final String? email;
  SignInScreenTwo({required this.email, Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignInViewModel(),
      child: Consumer<SignInViewModel>(
        builder: (context, model, child) => Scaffold(
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
                      'Sign in',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Text(
                    'Lets prove its you by entering your password!',
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
                        model.signInUserAccount(email!, value);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
