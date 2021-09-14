import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum Salary {
  ZeroTwoLpa,
  TwoToFiveLpa,
  FiveToSevenLpa,
  SevenToTenLpa,
  AboveTenLpa
}

class SalaryScreen extends StatefulWidget {
  const SalaryScreen({Key? key}) : super(key: key);

  @override
  _SalaryScreenState createState() => _SalaryScreenState();
}

class _SalaryScreenState extends State<SalaryScreen> {
  Salary? _reply;

  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((val) {
      if (val.data()!.containsKey('salary')) {
        if (val['salary'] == "0-2.5 Lpa") {
          setState(() {
            _reply = Salary.ZeroTwoLpa;
          });
        } else if (val['salary'] == "2.5-5 Lpa") {
          setState(() {
            _reply = Salary.TwoToFiveLpa;
          });
        } else if (val['salary'] == "5-7.5 Lpa") {
          setState(() {
            _reply = Salary.FiveToSevenLpa;
          });
        } else if (val['salary'] == "7.5-10 Lpa") {
          setState(() {
            _reply = Salary.SevenToTenLpa;
          });
        } else if (val['salary'] == "Above 10 Lpa") {
          setState(() {
            _reply = Salary.AboveTenLpa;
          });
        }
      } else {
        setState(() {
            _reply = Salary.ZeroTwoLpa;
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
              'Whats Your Salary?',
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
                  _reply = Salary.ZeroTwoLpa;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Salary.ZeroTwoLpa,
                    groupValue: _reply,
                    onChanged: (Salary? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('0-2.5 Lpa'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Salary.TwoToFiveLpa;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Salary.TwoToFiveLpa,
                    groupValue: _reply,
                    onChanged: (Salary? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('2.5-5 Lpa'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Salary.FiveToSevenLpa;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Salary.FiveToSevenLpa,
                    groupValue: _reply,
                    onChanged: (Salary? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('5-7.5 Lpa'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Salary.SevenToTenLpa;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Salary.SevenToTenLpa,
                    groupValue: _reply,
                    onChanged: (Salary? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('7.5-10 Lpa'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Salary.AboveTenLpa;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Salary.AboveTenLpa,
                    groupValue: _reply,
                    onChanged: (Salary? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Above 10 Lpa'),
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
                if (_reply == Salary.ZeroTwoLpa) {
                  DataBaseMethods().addUserSalary("0-2.5 Lpa");
                } else if (_reply == Salary.TwoToFiveLpa) {
                  DataBaseMethods().addUserSalary("2.5-5 Lpa");
                } else if (_reply == Salary.FiveToSevenLpa) {
                  DataBaseMethods().addUserSalary("5-7.5 Lpa");
                } else if (_reply == Salary.SevenToTenLpa) {
                  DataBaseMethods().addUserSalary("7.5-10 Lpa");
                } else if (_reply == Salary.AboveTenLpa) {
                  DataBaseMethods().addUserSalary("Above 10 Lpa");
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
