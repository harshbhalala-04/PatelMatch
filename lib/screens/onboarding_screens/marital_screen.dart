import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/screens/onboarding_screens/NRI_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Marital { Unmarried, Widow, Divorced, Seperated }

class MaritalScreen extends StatefulWidget {
  final bool fromProfile;
  String response;
  MaritalScreen({required this.fromProfile, this.response = ''});

  @override
  _MaritalScreenState createState() => _MaritalScreenState();
}

class _MaritalScreenState extends State<MaritalScreen> {
  Marital? _reply;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.response == 'Unmarried') {
      setState(() {
        _reply = Marital.Unmarried;
      });
    } else if (widget.response == 'Widow') {
      setState(() {
        _reply = Marital.Widow;
      });
    } else if (widget.response == 'Divorced') {
      setState(() {
        _reply = Marital.Divorced;
      });
    } else if (widget.response == 'Seperated') {
      setState(() {
        _reply = Marital.Seperated;
      });
    } else {
      setState(() {
        _reply = Marital.Unmarried;
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
                  if (widget.fromProfile) {
                    final globalController = Get.put(GlobalController());
                    Get.find<GlobalController>()
                        .currentAppuser
                        .value
                        .maritalStatus = "Unmarried";
                  }
                  DataBaseMethods().addUserMaritalStatus("Unmarried");
                } else if (_reply == Marital.Widow) {
                  if (widget.fromProfile) {
                    final globalController = Get.put(GlobalController());
                    Get.find<GlobalController>()
                        .currentAppuser
                        .value
                        .maritalStatus = "Widow/Widower";
                  }
                  DataBaseMethods().addUserMaritalStatus("Widow/Widower");
                } else if (_reply == Marital.Divorced) {
                  if (widget.fromProfile) {
                    final globalController = Get.put(GlobalController());
                    Get.find<GlobalController>()
                        .currentAppuser
                        .value
                        .maritalStatus = "Divorced";
                  }
                  DataBaseMethods().addUserMaritalStatus("Divorced");
                } else if (_reply == Marital.Seperated) {
                  if (widget.fromProfile) {
                    final globalController = Get.put(GlobalController());
                    Get.find<GlobalController>()
                        .currentAppuser
                        .value
                        .maritalStatus = "Seperated";
                  }
                  DataBaseMethods().addUserMaritalStatus("Seperated");
                }
                if (widget.fromProfile) {
                  // Navigator.pop(context);
                    Get.off(EditProfileScreen());
                } else {
                  Get.to(NRIScreen(
                    fromProfile: false,
                  ));
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
