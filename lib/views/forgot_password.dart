import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_basics/widgets/cutom_widgets.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  forgotPassword(String email) async {
    if (email == "") {
      return CustomWidgets.customAlertDialog(context, "Enter a valid email");
    } else {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomWidgets.customTextField(
                emailController, "Email", Icons.email, false),
            CustomWidgets.customSizedBox(20),
            CustomWidgets.customButton(() {
              forgotPassword(emailController.text.toString());
            }, "Reset Password")
          ],
        ),
      ),
    );
  }
}
