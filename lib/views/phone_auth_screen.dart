import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_basics/views/otp_verify_screen.dart';
import 'package:flutter_firebase_basics/widgets/cutom_widgets.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  TextEditingController phoneController = TextEditingController();

  phoneAuth(String phoneno) async {
    if (phoneno == "") {
      return CustomWidgets.customAlertDialog(
          context, "Enter the required Phone number");
    } else {
      await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException ex) {
          CustomWidgets.customAlertDialog(context, ex.code.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OTPVerifyScreen(verificationId: verificationId),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        phoneNumber: phoneno,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login using Phone number'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomWidgets.customTextField(
                phoneController, "Enter the Phone Number", Icons.phone, false),
            CustomWidgets.customSizedBox(20),
            CustomWidgets.customButton(() {
              phoneAuth(phoneController.text.toString());
            }, "Get OTP"),
          ],
        ),
      ),
    );
  }
}
