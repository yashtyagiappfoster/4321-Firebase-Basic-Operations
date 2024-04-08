import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_basics/widgets/cutom_widgets.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  addData(String name, String address) async {
    if (name == "" && address == "") {
      return CustomWidgets.customAlertDialog(context, "Enter Required Fields.");
    } else {
      FirebaseFirestore.instance.collection("Users").doc(name).set({
        "name": name,
        "address": address,
      }).then((value) {
        return CustomWidgets.customAlertDialog(context, "Data Inserted");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Data to Firebase'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomWidgets.customTextField(
                nameController, "Name", Icons.person, false),
            CustomWidgets.customSizedBox(15),
            CustomWidgets.customTextField(
                addressController, "Address", Icons.details, false),
            CustomWidgets.customSizedBox(25),
            CustomWidgets.customButton(() {
              addData(nameController.text.toString(),
                  addressController.text.toString());
            }, "Save Data"),
          ],
        ),
      ),
    );
  }
}
