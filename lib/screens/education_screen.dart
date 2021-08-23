import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/widgets/database_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum Education {
  PursuingBachelors,
  CompletedBachelors,
  PursuingMasters,
  CompletedMasters,
  Other,
}

class EducationScreen extends StatefulWidget {
  @override
  _EducationScreenState createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  Education? _reply;

  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
      if (val.data()!.containsKey('education')) {
        if (val['education'] == 'Completed Bachelors') {
          setState(() {
            _reply = Education.CompletedBachelors;
          });
        } else if (val['education'] == 'Pursuing Bachelors') {
          setState(() {
            _reply = Education.PursuingBachelors;
          });
        } else if (val['education'] == 'Pursuing Masters') {
          setState(() {
            _reply = Education.PursuingMasters;
          });
        } else if (val['education'] == 'Completed Masters') {
          setState(() {
            _reply = Education.CompletedMasters;
          });
        } else if (val['education'] == "Other") {
          setState(() {
            _reply = Education.Other;
          });
        }
      } else {
        setState(() {
            _reply = Education.CompletedBachelors;
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
          onPressed: () => Navigator.of(context).pop(),
        ),
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
              'Whats Your Education?',
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
                  _reply = Education.PursuingBachelors;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Education.PursuingBachelors,
                    groupValue: _reply,
                    onChanged: (Education? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Pursuing Bachelors'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Education.CompletedBachelors;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Education.CompletedBachelors,
                    groupValue: _reply,
                    onChanged: (Education? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Completed Bachelors'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Education.PursuingMasters;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Education.PursuingMasters,
                    groupValue: _reply,
                    onChanged: (Education? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Pursuing Masters'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Education.CompletedMasters;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Education.CompletedMasters,
                    groupValue: _reply,
                    onChanged: (Education? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Completed Masters'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Education.Other;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Education.Other,
                    groupValue: _reply,
                    onChanged: (Education? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Other'),
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
                if (_reply == Education.CompletedBachelors) {
                  DataBaseMethods().addUserEducation("Completed Bachelors");
                } else if (_reply == Education.PursuingBachelors) {
                  DataBaseMethods().addUserEducation("Pursuing Bachelors");
                } else if (_reply == Education.PursuingMasters) {
                  DataBaseMethods().addUserEducation("Pursuing Masters");
                } else if (_reply == Education.CompletedMasters) {
                  DataBaseMethods().addUserEducation("Completed Masters");
                } else if (_reply == Education.Other) {
                  DataBaseMethods().addUserEducation("Other");
                }

                Navigator.pop(context);
                      Navigator.popAndPushNamed(
                          context, EditProfileScreen.routeName);
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
