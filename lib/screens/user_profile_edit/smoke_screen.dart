import 'package:chat/controllers/global_controller.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Smoke { Never, Socially, Regularly, Planningtoquit }

class SmokeScreen extends StatefulWidget {
  final bool fromProfile;
  String response;
  SmokeScreen({required this.fromProfile, this.response = ''});

  @override
  _SmokeScreenState createState() => _SmokeScreenState();
}

class _SmokeScreenState extends State<SmokeScreen> {
  Smoke? _reply;

  @override
  void initState() {
    if (widget.response == 'Never') {
      setState(() {
        _reply = Smoke.Never;
      });
    } else if (widget.response == 'Socially') {
      setState(() {
        _reply = Smoke.Socially;
      });
    } else if (widget.response == 'Regularly') {
      setState(() {
        _reply = Smoke.Regularly;
      });
    } else if (widget.response == 'Planning to quit') {
      setState(() {
        _reply = Smoke.Planningtoquit;
      });
    } else {
      setState(() {
        _reply = Smoke.Never;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('PM', style: TextStyle(color: Color.fromRGBO(255, 85, 115, 1), fontSize: 24),),
        centerTitle: true,
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
              'Do You Smoke?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Smoke.Never;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Smoke.Never,
                    groupValue: _reply,
                    onChanged: (Smoke? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Never'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Smoke.Socially;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Smoke.Socially,
                    groupValue: _reply,
                    onChanged: (Smoke? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Socially'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Smoke.Regularly;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Smoke.Regularly,
                    groupValue: _reply,
                    onChanged: (Smoke? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Regularly'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Smoke.Planningtoquit;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Smoke.Planningtoquit,
                    groupValue: _reply,
                    onChanged: (Smoke? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Planning to quit'),
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
                if (_reply == Smoke.Never) {
                  Get.find<GlobalController>().currentAppuser.value.smoke =
                      "Never";
                  DataBaseMethods().addUserSmoke("Never");
                } else if (_reply == Smoke.Socially) {
                  Get.find<GlobalController>().currentAppuser.value.smoke =
                      "Socially";
                  DataBaseMethods().addUserSmoke("Socially");
                } else if (_reply == Smoke.Regularly) {
                  Get.find<GlobalController>().currentAppuser.value.smoke =
                      "Regularly";
                  DataBaseMethods().addUserSmoke("Regularly");
                } else if (_reply == Smoke.Planningtoquit) {
                  Get.find<GlobalController>().currentAppuser.value.smoke =
                      "Planning to quit";
                  DataBaseMethods().addUserSmoke("Planning to quit");
                }
                // Navigator.pop(context);
                    Get.off(EditProfileScreen());
                // Navigator.pop(context);
                // Navigator.popAndPushNamed(context, EditProfileScreen.routeName);
              },
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(255, 85, 115, 0.89),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
