import 'package:chat/helper/constants.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../database/database.dart';
import 'image_picker_screen.dart';

class UserNameScreen extends StatefulWidget {
  late final fromProfile;

  UserNameScreen({required this.fromProfile});

  @override
  _UserNameScreenState createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  TextEditingController _usernameController = new TextEditingController();

  @override
  void initState() {
    if (widget.fromProfile) {
      _usernameController.text = DataBaseMethods().fetchUserName();
    }
    super.initState();
  }

  void showDialog() {
    Get.defaultDialog(
      middleText: "Plese Select Your Name",
      title: "",
      middleTextStyle: TextStyle(fontSize: 20),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('Close'),
                style: TextButton.styleFrom(
                  textStyle: TextStyle(fontSize: 16)
                )
              ),
          ],
        )
      ],
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Enter Your Full Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'Start Typing...',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(width: 2),
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please Enter Your name';
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              child: ElevatedButton(
                onPressed: () {
                  String username = _usernameController.text;
                  if (widget.fromProfile) {
                    if (username.isEmpty) {
                      showDialog();
                    } else {
                      Constants.username = username;
                      DataBaseMethods().updateUserName(username);
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(
                          context, EditProfileScreen.routeName);
                    }
                  } else {
                    if (username.isEmpty) {
                      showDialog();
                    } else {
                      DataBaseMethods().addUsername(username);
                      Get.to(ImagePickerScreen());
                    }
                  }
                },
                child: widget.fromProfile
                    ? Text(
                        'Submit',
                        style: TextStyle(fontSize: 17),
                        textAlign: TextAlign.center,
                      )
                    : Text('Continue',
                        style: TextStyle(fontSize: 17),
                        textAlign: TextAlign.center),
                style: ButtonStyle(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
