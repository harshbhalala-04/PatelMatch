import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/database/database.dart';
import 'package:chat/screens/onboarding_screens/weight_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'community_screen.dart';

enum Gender { Male, Female }

class GenderScreen extends StatefulWidget {
  late final fromProfile;

  GenderScreen({required this.fromProfile});

  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  Gender? _reply;

  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
      if (val.data()!.containsKey('gender')) {
        if (val['gender'] == 'Male') {
          setState(() {
            _reply = Gender.Male;
          });
        } else if (val['gender'] == 'Female') {
          setState(() {
            _reply = Gender.Female;
          });
        }
      } else {
        setState(() {
          _reply = Gender.Male;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          widget.fromProfile
              ? Container(
                  height: 0,
                )
              : TextButton(
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    DataBaseMethods().addUserGender('Male');
                    Get.to(CommunityScreen(fromProfile: false));
                  },
                )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Select Your Gender',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Gender.Male;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Gender.Male,
                    groupValue: _reply,
                    onChanged: (Gender? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Male'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Gender.Female;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Gender.Female,
                    groupValue: _reply,
                    onChanged: (Gender? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Female'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: ElevatedButton(
              onPressed: () {
                if (_reply == Gender.Male) {
                  DataBaseMethods().addUserGender("Male");
                } else {
                  DataBaseMethods().addUserGender("Female");
                }

                if (widget.fromProfile) {
                  Navigator.pop(context);
                  Navigator.popAndPushNamed(
                      context, EditProfileScreen.routeName);
                } else {
                  Get.to(WeightScreen());
                }
              },
              child: widget.fromProfile
                  ? Text(
                      'Submit',
                      style: TextStyle(fontSize: 17),
                    )
                  : Text(
                      'Continue',
                      style: TextStyle(fontSize: 17),
                    ),
              style: ButtonStyle(),
            ),
          ),
        ),
      ),
    );
  }
}
