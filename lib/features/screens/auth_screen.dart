// ignore_for_file: prefer_const_constructors, unused_field

import 'package:amazon_clone/common/widget/custom_button.dart';
import 'package:amazon_clone/common/widget/custom_textField.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth {
  signup,
  signin,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signupFormKey = GlobalKey<FormState>();
  final _signinFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  bool isLoggedin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  tileColor: _auth == Auth.signup
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundColor,
                  title: Text(
                    "Create account",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  leading: Radio(
                      activeColor: GlobalVariables.secondaryColor,
                      value: Auth.signup,
                      groupValue: _auth,
                      onChanged: (Auth? val) {
                        setState(() {
                          _auth = val!;
                        });
                      }),
                ),
                if (_auth == Auth.signup)
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: Form(
                        key: _signupFormKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _emailController,
                              hintText: "Email",
                              obscureText: false,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: _nameController,
                              hintText: "User name",
                              obscureText: false,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: _fullNameController,
                              hintText: "Full name",
                              obscureText: false,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: _passwordController,
                              hintText: "Password",
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                                text: "Sign Up",
                                onTap: () => signUpUser(
                                    context: context,
                                    email: _emailController.text,
                                    username: _nameController.text,
                                    fullname: _fullNameController.text,
                                    password: _passwordController.text,
                                    isLoggedIn: isLoggedin))
                          ],
                        )),
                  ),
                ListTile(
                  tileColor: _auth == Auth.signin
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundColor,
                  title: Text(
                    "Sign-In.",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  leading: Radio(
                      activeColor: GlobalVariables.secondaryColor,
                      value: Auth.signin,
                      groupValue: _auth,
                      onChanged: (Auth? val) {
                        setState(() {
                          _auth = val!;
                        });
                      }),
                ),
                if (_auth == Auth.signin)
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: Form(
                        key: _signupFormKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _nameController,
                              hintText: "Username",
                              obscureText: false,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: _passwordController,
                              hintText: "Password",
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                                text: "Sign-In",
                                onTap: () => userSignIn(
                                    context: context,
                                    username: _nameController.text,
                                    password: _passwordController.text))
                          ],
                        )),
                  ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
