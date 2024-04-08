import 'package:flutter/material.dart';
import 'package:flutter_firebase_basics/views/home_screen.dart';
import 'package:flutter_firebase_basics/widgets/cutom_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailContoller = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();

  signUp(String email, String password) async {
    if (email == "" && password == "") {
      return CustomWidgets.customAlertDialog(context, "Enter Required Fields");
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
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
        title: const Text('SignUp Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomWidgets.customTextField(
                nameController, 'Name', Icons.person, false),
            CustomWidgets.customSizedBox(15),
            CustomWidgets.customTextField(
                emailContoller, 'Email', Icons.email, false),
            CustomWidgets.customSizedBox(15),
            CustomWidgets.customTextField(
                passwordContoller, 'Password', Icons.password, true),
            CustomWidgets.customSizedBox(30),
            CustomWidgets.customButton(() {
              signUp(
                emailContoller.text.toString(),
                passwordContoller.text.toString(),
              );
              nameController.text = "";
              emailContoller.text = "";
              passwordContoller.text = "";
            }, 'SignUp'),
          ],
        ),
      ),
    );
  }
}
