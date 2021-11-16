import 'package:chat/controllers/global_controller.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Salary {
  ZeroTwoLpa,
  TwoToFiveLpa,
  FiveToSevenLpa,
  SevenToTenLpa,
  AboveTenLpa
}

class SalaryScreen extends StatefulWidget {
  final bool fromProfile;
  String response;
  final String relation;
  SalaryScreen(
      {required this.fromProfile, required this.relation, this.response = ''});

  @override
  _SalaryScreenState createState() => _SalaryScreenState();
}

class _SalaryScreenState extends State<SalaryScreen> {
  Salary? _reply;

  @override
  void initState() {
    if (widget.response == "0 - 2.5 Lpa") {
      setState(() {
        _reply = Salary.ZeroTwoLpa;
      });
    } else if (widget.response == "2.5 - 5 Lpa") {
      setState(() {
        _reply = Salary.TwoToFiveLpa;
      });
    } else if (widget.response == "5 - 7.5 Lpa") {
      setState(() {
        _reply = Salary.FiveToSevenLpa;
      });
    } else if (widget.response == "7.5 - 10 Lpa") {
      setState(() {
        _reply = Salary.SevenToTenLpa;
      });
    } else if (widget.response == "Above 10 Lpa") {
      setState(() {
        _reply = Salary.AboveTenLpa;
      });
    } else {
      setState(() {
        _reply = Salary.ZeroTwoLpa;
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
              'Whats Your ${widget.relation} Average Annual Income?',
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
                  Text('0 - 2.5 Lpa'),
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
                  Text('2.5 - 5 Lpa'),
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
                  Text('5 - 7.5 Lpa'),
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
                  Text('7.5 - 10 Lpa'),
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
                if (widget.relation == ' ') {
                  if (_reply == Salary.ZeroTwoLpa) {
                    Get.find<GlobalController>().currentAppuser.value.salary =
                        "0 - 2.5 Lpa";
                    DataBaseMethods().addUserSalary("0 - 2.5 Lpa");
                  } else if (_reply == Salary.TwoToFiveLpa) {
                    Get.find<GlobalController>().currentAppuser.value.salary =
                        "2.5 - 5 Lpa";
                    DataBaseMethods().addUserSalary("2.5 - 5 Lpa");
                  } else if (_reply == Salary.FiveToSevenLpa) {
                    Get.find<GlobalController>().currentAppuser.value.salary =
                        "5 - 7.5 Lpa";
                    DataBaseMethods().addUserSalary("5 - 7.5 Lpa");
                  } else if (_reply == Salary.SevenToTenLpa) {
                    Get.find<GlobalController>().currentAppuser.value.salary =
                        "7.5 - 10 Lpa";
                    DataBaseMethods().addUserSalary("7.5 - 10 Lpa");
                  } else if (_reply == Salary.AboveTenLpa) {
                    Get.find<GlobalController>().currentAppuser.value.salary =
                        "Above 10 Lpa";
                    DataBaseMethods().addUserSalary("Above 10 Lpa");
                  }
                }
                else if (widget.relation == "Father's") {
                  if (_reply == Salary.ZeroTwoLpa) {
                    Get.find<GlobalController>().currentAppuser.value.fatherAvgAnnualIncome =
                        "0 - 2.5 Lpa";
                    DataBaseMethods().addFatherSalary("0 - 2.5 Lpa");
                  } else if (_reply == Salary.TwoToFiveLpa) {
                    Get.find<GlobalController>().currentAppuser.value.fatherAvgAnnualIncome =
                        "2.5 - 5 Lpa";
                    DataBaseMethods().addFatherSalary("2.5 - 5 Lpa");
                  } else if (_reply == Salary.FiveToSevenLpa) {
                    Get.find<GlobalController>().currentAppuser.value.fatherAvgAnnualIncome =
                        "5 - 7.5 Lpa";
                    DataBaseMethods().addFatherSalary("5 - 7.5 Lpa");
                  } else if (_reply == Salary.SevenToTenLpa) {
                    Get.find<GlobalController>().currentAppuser.value.fatherAvgAnnualIncome =
                        "7.5 - 10 Lpa";
                    DataBaseMethods().addFatherSalary("7.5 - 10 Lpa");
                  } else if (_reply == Salary.AboveTenLpa) {
                    Get.find<GlobalController>().currentAppuser.value.fatherAvgAnnualIncome =
                        "Above 10 Lpa";
                    DataBaseMethods().addFatherSalary("Above 10 Lpa");
                  }
                }

                else if (widget.relation == "Mother's") {
                  if (_reply == Salary.ZeroTwoLpa) {
                    Get.find<GlobalController>().currentAppuser.value.motherAvgAnnualIncome =
                        "0 - 2.5 Lpa";
                    DataBaseMethods().addMotherSalary("0 - 2.5 Lpa");
                  } else if (_reply == Salary.TwoToFiveLpa) {
                    Get.find<GlobalController>().currentAppuser.value.motherAvgAnnualIncome =
                        "2.5 - 5 Lpa";
                    DataBaseMethods().addMotherSalary("2.5 - 5 Lpa");
                  } else if (_reply == Salary.FiveToSevenLpa) {
                    Get.find<GlobalController>().currentAppuser.value.motherAvgAnnualIncome =
                        "5 - 7.5 Lpa";
                    DataBaseMethods().addMotherSalary("5 - 7.5 Lpa");
                  } else if (_reply == Salary.SevenToTenLpa) {
                    Get.find<GlobalController>().currentAppuser.value.motherAvgAnnualIncome =
                        "7.5 - 10 Lpa";
                    DataBaseMethods().addMotherSalary("7.5 - 10 Lpa");
                  } else if (_reply == Salary.AboveTenLpa) {
                    Get.find<GlobalController>().currentAppuser.value.motherAvgAnnualIncome =
                        "Above 10 Lpa";
                    DataBaseMethods().addMotherSalary("Above 10 Lpa");
                  }
                }
                Get.off(EditProfileScreen());
                // Navigator.pop(context);
                // Navigator.popAndPushNamed(context, EditProfileScreen.routeName);
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
