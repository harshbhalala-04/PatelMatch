import 'package:chat/controllers/global_controller.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Worklife { Government, Defence, Private, SelfEmployed, NotWorking }

class WorkLifeScreen extends StatefulWidget {
  final bool fromProfile;
  final String relation;
  String response;
  WorkLifeScreen(
      {required this.fromProfile, required this.relation, this.response = ''});

  @override
  _WorkLifeScreenState createState() => _WorkLifeScreenState();
}

class _WorkLifeScreenState extends State<WorkLifeScreen> {
  Worklife? _reply;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.response == 'Government') {
      setState(() {
        _reply = Worklife.Government;
      });
    } else if (widget.response == 'Self-Employed') {
      setState(() {
        _reply = Worklife.SelfEmployed;
      });
    } else if (widget.response == 'Defence') {
      setState(() {
        _reply = Worklife.Defence;
      });
    } else if (widget.response == 'Private') {
      setState(() {
        _reply = Worklife.Private;
      });
    } else if (widget.response == 'Not Working') {
      setState(() {
        _reply = Worklife.NotWorking;
      });
    } else {
      setState(() {
        _reply = Worklife.Government;
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
              'Your ${widget.relation} Work Life',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Worklife.Government;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Worklife.Government,
                    groupValue: _reply,
                    onChanged: (Worklife? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Government'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Worklife.SelfEmployed;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Worklife.SelfEmployed,
                    groupValue: _reply,
                    onChanged: (Worklife? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Self-Employed'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Worklife.Private;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Worklife.Private,
                    groupValue: _reply,
                    onChanged: (Worklife? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Private'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Worklife.Defence;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Worklife.Defence,
                    groupValue: _reply,
                    onChanged: (Worklife? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Defence'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Worklife.NotWorking;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Worklife.NotWorking,
                    groupValue: _reply,
                    onChanged: (Worklife? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Not Working'),
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
                if (widget.relation == ' ') {
                  if (_reply == Worklife.Defence) {
                    Get.find<GlobalController>().currentAppuser.value.worklife =
                        'Defence';
                    DataBaseMethods().addUserWorklife("Defence");
                  } else if (_reply == Worklife.SelfEmployed) {
                    Get.find<GlobalController>().currentAppuser.value.worklife =
                        'Self-Employed';
                    DataBaseMethods().addUserWorklife("Self-Employed");
                  } else if (_reply == Worklife.Government) {
                    Get.find<GlobalController>().currentAppuser.value.worklife =
                        'Government';
                    DataBaseMethods().addUserWorklife("Government");
                  } else if (_reply == Worklife.Private) {
                    Get.find<GlobalController>().currentAppuser.value.worklife =
                        'Private';
                    DataBaseMethods().addUserWorklife("Private");
                  } else {
                    Get.find<GlobalController>().currentAppuser.value.worklife =
                        'Not Working';
                    DataBaseMethods().addUserWorklife("Not Working");
                  }
                }
                if (widget.relation == "Father's") {
                  if (_reply == Worklife.Defence) {
                    Get.find<GlobalController>().currentAppuser.value.fatherOccupation =
                        'Defence';
                    DataBaseMethods().addFatherWorklife("Defence");
                  } else if (_reply == Worklife.SelfEmployed) {
                    Get.find<GlobalController>().currentAppuser.value.fatherOccupation =
                        'Self-Employed';
                    DataBaseMethods().addFatherWorklife("Self-Employed");
                  } else if (_reply == Worklife.Government) {
                    Get.find<GlobalController>().currentAppuser.value.fatherOccupation =
                        'Government';
                    DataBaseMethods().addFatherWorklife("Government");
                  } else if (_reply == Worklife.Private) {
                    Get.find<GlobalController>().currentAppuser.value.fatherOccupation =
                        'Private';
                    DataBaseMethods().addFatherWorklife("Private");
                  } else {
                    Get.find<GlobalController>().currentAppuser.value.fatherOccupation =
                        'Not Working';
                    DataBaseMethods().addFatherWorklife("Not Working");
                  }
                }

                if (widget.relation == "Mother's") {
                  if (_reply == Worklife.Defence) {
                    Get.find<GlobalController>().currentAppuser.value.motherOccupation =
                        'Defence';
                    DataBaseMethods().addMotherWorklife("Defence");
                  } else if (_reply == Worklife.SelfEmployed) {
                    Get.find<GlobalController>().currentAppuser.value.motherOccupation =
                        'Self-Employed';
                    DataBaseMethods().addMotherWorklife("Self-Employed");
                  } else if (_reply == Worklife.Government) {
                    Get.find<GlobalController>().currentAppuser.value.motherOccupation =
                        'Government';
                    DataBaseMethods().addMotherWorklife("Government");
                  } else if (_reply == Worklife.Private) {
                    Get.find<GlobalController>().currentAppuser.value.motherOccupation =
                        'Private';
                    DataBaseMethods().addMotherWorklife("Private");
                  } else {
                    Get.find<GlobalController>().currentAppuser.value.motherOccupation =
                        'Not Working';
                    DataBaseMethods().addMotherWorklife("Not Working");
                  }
                }

                // Navigator.pop(context);
                // Navigator.popAndPushNamed(context, EditProfileScreen.routeName);
                Get.off(EditProfileScreen());
              },
              child: Text(
                'Submit',
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
