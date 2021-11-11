import 'package:chat/controllers/global_controller.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Drink { Never, Socially, Regularly, Planningtoquit }

class DrinkScreen extends StatefulWidget {
  final bool fromProfile;
  String response;
  DrinkScreen({required this.fromProfile, this.response = ''});

  @override
  _DrinkScreenState createState() => _DrinkScreenState();
}

class _DrinkScreenState extends State<DrinkScreen> {
  Drink? _reply;

  @override
  void initState() {
    if (widget.response == 'Never') {
      setState(() {
        _reply = Drink.Never;
      });
    } else if (widget.response == 'Socially') {
      setState(() {
        _reply = Drink.Socially;
      });
    } else if (widget.response == 'Regularly') {
      setState(() {
        _reply = Drink.Regularly;
      });
    } else if (widget.response == 'Planning to quit') {
      setState(() {
        _reply = Drink.Planningtoquit;
      });
    } else {
      setState(() {
        _reply = Drink.Never;
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
              'Do You Drink?',
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
                  _reply = Drink.Never;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Drink.Never,
                    groupValue: _reply,
                    onChanged: (Drink? value) {
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
                  _reply = Drink.Socially;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Drink.Socially,
                    groupValue: _reply,
                    onChanged: (Drink? value) {
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
                  _reply = Drink.Regularly;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Drink.Regularly,
                    groupValue: _reply,
                    onChanged: (Drink? value) {
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
                  _reply = Drink.Planningtoquit;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Drink.Planningtoquit,
                    groupValue: _reply,
                    onChanged: (Drink? value) {
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
                if (_reply == Drink.Never) {
                  Get.find<GlobalController>().currentAppuser.value.drink =
                      "Never";
                  DataBaseMethods().addUserDrink("Never");
                } else if (_reply == Drink.Socially) {
                  Get.find<GlobalController>().currentAppuser.value.drink =
                      "Socially";
                  DataBaseMethods().addUserDrink("Socially");
                } else if (_reply == Drink.Regularly) {
                  Get.find<GlobalController>().currentAppuser.value.drink =
                      "Regularly";
                  DataBaseMethods().addUserDrink("Regularly");
                } else if (_reply == Drink.Planningtoquit) {
                  Get.find<GlobalController>().currentAppuser.value.drink =
                      "Planning to quit";
                  DataBaseMethods().addUserDrink("Planning to quit");
                }

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
