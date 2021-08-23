import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/widgets/database_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum Worklife { Employed, SelfEmployed, ActivelyLooking, Others }

class WorkLifeScreen extends StatefulWidget {
  const WorkLifeScreen({Key? key}) : super(key: key);

  @override
  _WorkLifeScreenState createState() => _WorkLifeScreenState();
}

class _WorkLifeScreenState extends State<WorkLifeScreen> {
  Worklife? _reply;

  @override
  void initState() {
    
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
      if (val.data()!.containsKey('worklife')) {
        if (val['worklife'] == "Employed") {
          setState(() {
            _reply = Worklife.Employed;
          });
        } else if (val['worklife'] == "Self-Employed") {
          setState(() {
            _reply = Worklife.SelfEmployed;
          });
        } else if (val['worklife'] == "Actively Looking") {
          setState(() {
            _reply = Worklife.ActivelyLooking;
          });
        } else if (val['worklife'] == "Others") {
          setState(() {
            _reply = Worklife.Others;
          });
        }
      } else {
        setState(() {
            _reply = Worklife.Employed;
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
              'Work Life',
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
                  _reply = Worklife.Employed;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Worklife.Employed,
                    groupValue: _reply,
                    onChanged: (Worklife? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Employed'),
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
                  _reply = Worklife.ActivelyLooking;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Worklife.ActivelyLooking,
                    groupValue: _reply,
                    onChanged: (Worklife? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Actively Looking'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Worklife.Others;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Worklife.Others,
                    groupValue: _reply,
                    onChanged: (Worklife? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Others'),
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
                if (_reply == Worklife.Employed) {
                  DataBaseMethods().addUserWorklife("Employed");
                } else if (_reply == Worklife.SelfEmployed) {
                  DataBaseMethods().addUserWorklife("Self-Employed");
                } else if (_reply == Worklife.ActivelyLooking) {
                  DataBaseMethods().addUserWorklife("Actively Looking");
                } else if (_reply == Worklife.Others) {
                  DataBaseMethods().addUserWorklife("Others");
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
