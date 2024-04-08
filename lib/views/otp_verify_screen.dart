import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_basics/views/home_screen.dart';
import 'package:flutter_firebase_basics/widgets/cutom_widgets.dart';

class OTPVerifyScreen extends StatefulWidget {
  final String verificationId;
  const OTPVerifyScreen({required this.verificationId, super.key});

  @override
  State<OTPVerifyScreen> createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends State<OTPVerifyScreen> {
  TextEditingController otpController = TextEditingController();

  verifyOtp(String otp) async {
    if (otp == "") {
      return CustomWidgets.customAlertDialog(context, "Enter the required OTP");
    } else {
      try {
        PhoneAuthCredential credential = await PhoneAuthProvider.credential(
            verificationId: widget.verificationId, smsCode: otp);
        FirebaseAuth.instance.signInWithCredential(credential).then(
          (value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
        );
      } catch (ex) {
        return CustomWidgets.customAlertDialog(context, ex.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification Screen'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomWidgets.customTextField(
                otpController, "Enter the OTP", Icons.code, false),
            CustomWidgets.customSizedBox(20),
            CustomWidgets.customButton(() {
              verifyOtp(otpController.text.toString());
            }, "Verify OTP"),
          ],
        ),
      ),
    );
  }
}
