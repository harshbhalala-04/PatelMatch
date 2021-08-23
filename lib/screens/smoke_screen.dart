import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/widgets/database_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum Smoke { Never, Socially, Regularly, Planningtoquit }

class SmokeScreen extends StatefulWidget {
  const SmokeScreen({Key? key}) : super(key: key);

  @override
  _SmokeScreenState createState() => _SmokeScreenState();
}

class _SmokeScreenState extends State<SmokeScreen> {
  Smoke? _reply;

  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
      if (val.data()!.containsKey('smoke')) {
        if (val['smoke'] == 'Never') {
          setState(() {
            _reply = Smoke.Never;
          });
        } else if (val['smoke'] == 'Socially') {
          setState(() {
            _reply = Smoke.Socially;
          });
        } else if (val['smoke'] == 'Regularly') {
          setState(() {
            _reply = Smoke.Regularly;
          });
        } else if (val['smoke'] == 'Planning to quit') {
          setState(() {
            _reply = Smoke.Planningtoquit;
          });
        }
      } else {
        setState(() {
          _reply = Smoke.Never;
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
                  DataBaseMethods().addUserSmoke("Never");
                } else if (_reply == Smoke.Socially) {
                  DataBaseMethods().addUserSmoke("Socially");
                } else if (_reply == Smoke.Regularly) {
                  DataBaseMethods().addUserSmoke("Regularly");
                } else if (_reply == Smoke.Planningtoquit) {
                  DataBaseMethods().addUserSmoke("Planning to quit");
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
