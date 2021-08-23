import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/screens/gender_screen.dart';
import 'package:chat/widgets/database_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BirthDateScreen extends StatefulWidget {
  late final fromProfile;

  BirthDateScreen({required this.fromProfile});
  @override
  _BirthDateScreenState createState() => _BirthDateScreenState();
}

class _BirthDateScreenState extends State<BirthDateScreen> {
  String dayValue = '1';
  String monthValue = '1';
  String yearValue = '2002';
  String dd = 'DD';
  String mm = 'MM';
  String yyyy = 'YYYY';
  final _dateController = TextEditingController();

  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
      if (val.data()!.containsKey('dd')) {
        setState(() {
          dd = val['dd'];
        mm = val['mm'];
        yyyy = val['yyyy'];

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
        actions: [
          widget.fromProfile
              ? Container(
                  height: 0,
                )
              : TextButton(
                  child: Text(
                    'Skip',
                    style: TextStyle(color: Colors.pink, fontSize: 18),
                  ),
                  onPressed: () {
                    DataBaseMethods().addUserBirthDate('', '', '');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => GenderScreen(
                                  fromProfile: false,
                                )));
                  },
                ),
        ],
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
              'Enter Your Birth Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Container(
                    width: 50,
                    child: TextField(
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime(DateTime.now().year - 18),
                                firstDate: DateTime(1940),
                                lastDate: DateTime(DateTime.now().year - 18))
                            .then((pickedDate) {
                          if (pickedDate == null) {
                            return;
                          } else {
                            setState(() {
                              dd = pickedDate.day.toString();
                              mm = pickedDate.month.toString();
                              yyyy = pickedDate.year.toString();
                            });
                          }
                        });
                      },
                      readOnly: true,
                      
                      decoration: InputDecoration(
                        hintText: dd == '' ? "DD" : dd,
                        
                        border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Flexible(
                    child: Container(
                  width: 60,
                  child: TextField(
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime(DateTime.now().year - 18),
                              firstDate: DateTime(1940),
                              lastDate: DateTime(DateTime.now().year - 18))
                          .then((pickedDate) {
                        if (pickedDate == null) {
                          return;
                        } else {
                          setState(() {
                            dd = pickedDate.day.toString();
                            mm = pickedDate.month.toString();
                            yyyy = pickedDate.year.toString();
                          });
                        }
                      });
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: mm == '' ? "MM" : mm,
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 2),
                      ),
                    ),
                  ),
                )),
                SizedBox(
                  width: 16,
                ),
                Flexible(
                    child: Container(
                  width: 80,
                  child: TextField(
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime(DateTime.now().year - 18),
                              firstDate: DateTime(1940),
                              lastDate: DateTime(DateTime.now().year - 18))
                          .then((pickedDate) {
                        if (pickedDate == null) {
                          return;
                        } else {
                          setState(() {
                            dd = pickedDate.day.toString();
                            mm = pickedDate.month.toString();
                            yyyy = pickedDate.year.toString();
                          });
                        }
                      });
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: yyyy == '' ? "YYYY" : yyyy,
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 2),
                      ),
                    ),
                  ),
                )),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today_rounded),
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime(DateTime.now().year - 18),
                            firstDate: DateTime(1940),
                            lastDate: DateTime(DateTime.now().year - 18))
                        .then((pickedDate) {
                      if (pickedDate == null) {
                        return;
                      } else {
                        setState(() {
                          dd = pickedDate.day.toString();
                          mm = pickedDate.month.toString();
                          yyyy = pickedDate.year.toString();
                        });
                      }
                    });
                  },
                  color: Colors.pink,
                  iconSize: 30,
                ),
              ],
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
                if (widget.fromProfile) {
                  if (dd == 'DD') {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Please Select Birth Date'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Close',
                                    style: TextStyle(color: Colors.pink),
                                  ))
                            ],
                          );
                        });
                  } else {
                    String date = dd;
                    String month = mm;
                    String year = yyyy;

                    DataBaseMethods().addUserBirthDate(date, month, year);
                    Navigator.pop(context);
                      Navigator.popAndPushNamed(
                          context, EditProfileScreen.routeName);
                  }
                } else {
                  if (dd == 'DD') {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Please Select Your Birth Date.'),
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
                    String date = dd;
                    String month = mm;
                    String year = yyyy;

                    DataBaseMethods().addUserBirthDate(date, month, year);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => GenderScreen(
                                  fromProfile: false,
                                )));
                  }
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
