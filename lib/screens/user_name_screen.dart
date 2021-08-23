import 'package:chat/helper/constants.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/database_method.dart';
import './image_picker_screen.dart';

class UserNameScreen extends StatefulWidget {
  late final fromProfile;

  UserNameScreen({required this.fromProfile});

  @override
  _UserNameScreenState createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  TextEditingController _usernameController = new TextEditingController();

  fetchUserName() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
      if (val.data()!.containsKey('username')) {
        _usernameController.text = val['username'];
      }
    });
  }

  @override
  void initState() {
    fetchUserName();
    super.initState();
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
                  //print(username);

                  if (widget.fromProfile) {
                    if (username.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Please Select Your Name.'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Close')),
                              ],
                            );
                          });
                    } else {
                      Constants.myName = username;
                      DataBaseMethods().updateUserName(username);
                      // Navigator.pop(context);

                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (ctx) => EditProfileScreen()));
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(
                          context, EditProfileScreen.routeName);
                    }
                  } else {
                    if (username.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Please Select Your Name.'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Close')),
                              ],
                            );
                          });
                    } else {
                      DataBaseMethods().addUsername(username);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => ImagePickerScreen()));
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
