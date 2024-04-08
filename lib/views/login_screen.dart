import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_basics/views/forgot_password.dart';
import 'package:flutter_firebase_basics/views/home_screen.dart';
import 'package:flutter_firebase_basics/views/phone_auth_screen.dart';
import 'package:flutter_firebase_basics/views/signup_screen.dart';
import 'package:flutter_firebase_basics/widgets/cutom_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(String email, String password) async {
    if (email == "" && password == "") {
      return CustomWidgets.customAlertDialog(context, 'Enter required Fields');
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then(
          (value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        return CustomWidgets.customAlertDialog(context, e.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomWidgets.customTextField(
                emailController, 'Email', Icons.email, false),
            CustomWidgets.customSizedBox(10),
            CustomWidgets.customTextField(
                passwordController, 'Password', Icons.password, true),
            CustomWidgets.customSizedBox(20),
            CustomWidgets.customButton(() {
              login(emailController.text.toString(),
                  passwordController.text.toString());
            }, 'Login'),
            CustomWidgets.customSizedBox(20),
            CustomWidgets.customTextButton(() {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const PhoneAuthScreen(),
                ),
              );
            }, "Login by phone number -->"),
            CustomWidgets.customSizedBox(20),
            CustomWidgets.customTextButton(
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpScreen(),
                  ),
                );
              },
              'Did not have an Account --> ',
            ),
            CustomWidgets.customSizedBox(20),
            CustomWidgets.customButton(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForgotPassword(),
                ),
              );
            }, "Forgot Password"),
          ],
        ),
      ),
    );
  }
}
