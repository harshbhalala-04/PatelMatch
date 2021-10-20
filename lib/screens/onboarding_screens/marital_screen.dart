import 'package:chat/database/database.dart';
import 'package:chat/screens/onboarding_screens/NRI_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Marital { Unmarried, Widow, Divorced, Seperated }

class MaritalScreen extends StatefulWidget {
  const MaritalScreen({Key? key}) : super(key: key);

  @override
  _MaritalScreenState createState() => _MaritalScreenState();
}

class _MaritalScreenState extends State<MaritalScreen> {
  Marital? _reply;
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
              'Marital Status',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Marital.Unmarried;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Marital.Unmarried,
                    groupValue: _reply,
                    onChanged: (Marital? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Unmarried'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Marital.Widow;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Marital.Widow,
                    groupValue: _reply,
                    onChanged: (Marital? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Widow/Widower'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Marital.Divorced;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Marital.Divorced,
                    groupValue: _reply,
                    onChanged: (Marital? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Divorced'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Marital.Seperated;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Marital.Seperated,
                    groupValue: _reply,
                    onChanged: (Marital? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Seperated'),
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
                if (_reply == Marital.Unmarried) {
                  DataBaseMethods().addUserMaritalStatus("Unmarried");
                } else if (_reply == Marital.Widow) {
                  DataBaseMethods().addUserMaritalStatus("Widow/Widower");
                } else if (_reply == Marital.Divorced) {
                  DataBaseMethods().addUserMaritalStatus("Divorced");
                } else if (_reply == Marital.Seperated) {
                  DataBaseMethods().addUserMaritalStatus("Seperated");
                } 

                Get.to(NRIScreen());
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
