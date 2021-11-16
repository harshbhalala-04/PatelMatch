import 'package:chat/controllers/global_controller.dart';
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
  final String relation;
  late final fromProfile;
  String response;

  UserNameScreen(
      {required this.relation, this.fromProfile, this.response = ''});

  @override
  _UserNameScreenState createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  TextEditingController _usernameController = new TextEditingController();

  @override
  void initState() {
    if (widget.fromProfile) {
      _usernameController.text = widget.response;
    }
    super.initState();
  }

  void showDialog() {
    Get.defaultDialog(
      middleText: "Plese Select Your ${widget.relation} Name",
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
                style:
                    TextButton.styleFrom(textStyle: TextStyle(fontSize: 16))),
          ],
        )
      ],
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          // automaticallyImplyLeading: false,
          title: Text('PM', style: TextStyle(color: Color.fromRGBO(255, 85, 115, 1), fontSize: 24),),
          centerTitle: true,
          leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
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
                'Enter Your${widget.relation} Full Name',
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
                      if (widget.relation == ' ') {
                        if (widget.fromProfile) {
                          Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .username = username;
                        }
                        Constants.username = username;
                        DataBaseMethods().updateUserName(username);
                      } else if (widget.relation == " Father") {
                        if (widget.fromProfile) {
                          final globalController = Get.put(GlobalController());
                          Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .fatherName = username;
                        }
                        DataBaseMethods().updateFatherName(username);
                      } else if (widget.relation == " Mother") {
                        if (widget.fromProfile) {
                          Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .motherName = username;
                        }
                        DataBaseMethods().updateMotherName(username);
                      }
                      Get.off(EditProfileScreen());
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
      
    );
  }
}
