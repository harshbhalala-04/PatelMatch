import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/widgets/database_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum Political { Conservative, Liberal, Moderate, Apolitical }

class PoliticalScreen extends StatefulWidget {
  const PoliticalScreen({Key? key}) : super(key: key);

  @override
  _PoliticalScreenState createState() => _PoliticalScreenState();
}

class _PoliticalScreenState extends State<PoliticalScreen> {
  Political? _reply;

  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
      if (val.data()!.containsKey('politics')) {
        if (val['politics'] == "Conservative") {
          setState(() {
            _reply = Political.Conservative;
          });
        } else if (val['politics'] == "Liberal") {
          setState(() {
            _reply = Political.Liberal;
          });
        } else if (val['politics'] == "Moderate") {
          setState(() {
            _reply = Political.Moderate;
          });
        } else if (val['politics'] == "Apolitical") {
          setState(() {
            _reply = Political.Apolitical;
          });
        }
      } else {
        setState(() {
             _reply = Political.Conservative;
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
              'What are your Political Inclinations?',
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
                  _reply = Political.Conservative;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Political.Conservative,
                    groupValue: _reply,
                    onChanged: (Political? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Conservative'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Political.Liberal;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Political.Liberal,
                    groupValue: _reply,
                    onChanged: (Political? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Liberal'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Political.Moderate;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Political.Moderate,
                    groupValue: _reply,
                    onChanged: (Political? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Moderate'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Political.Apolitical;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Political.Apolitical,
                    groupValue: _reply,
                    onChanged: (Political? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Apolitical'),
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
                if (_reply == Political.Conservative) {
                  DataBaseMethods().addUserPolitics("Conservative");
                } else if (_reply == Political.Liberal) {
                  DataBaseMethods().addUserPolitics("Liberal");
                } else if (_reply == Political.Moderate) {
                  DataBaseMethods().addUserPolitics("Moderate");
                } else if (_reply == Political.Apolitical) {
                  DataBaseMethods().addUserPolitics("Apolitical");
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
