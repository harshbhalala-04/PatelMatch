import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum Workout { Regularly, Sometimes, Never }

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}


class _WorkoutScreenState extends State<WorkoutScreen> {
  Workout? _reply;

  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
      if (val.data()!.containsKey('workout')) {
        if (val['workout'] == "Regularly") {
          setState(() {
            _reply = Workout.Regularly;
          });
        } else if (val['workout'] == "Sometimes") {
          setState(() {
            _reply = Workout.Sometimes;
          });
        } else if (val['workout'] == "Never") {
          setState(() {
            _reply = Workout.Never;
          });
        }
      } else {
        setState(() {
            _reply = Workout.Regularly;
          });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xE5E5E5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        shadowColor: Colors.white,
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
              'Do You Workout?',
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
                  _reply = Workout.Regularly;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Workout.Regularly,
                    groupValue: _reply,
                    onChanged: (Workout? value) {
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
                  _reply = Workout.Sometimes;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Workout.Sometimes,
                    groupValue: _reply,
                    onChanged: (Workout? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Sometimes'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Workout.Never;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Workout.Never,
                    groupValue: _reply,
                    onChanged: (Workout? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Never'),
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
                if (_reply == Workout.Regularly) {
                  DataBaseMethods().addUserWorkout("Regularly");
                } else if (_reply == Workout.Sometimes) {
                  DataBaseMethods().addUserWorkout("Sometimes");
                } else if (_reply == Workout.Never) {
                  DataBaseMethods().addUserWorkout("Never");
                }

                Navigator.pop(context);
                      Navigator.popAndPushNamed(
                          context, EditProfileScreen.routeName);
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
