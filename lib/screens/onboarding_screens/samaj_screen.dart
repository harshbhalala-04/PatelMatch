import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/screens/onboarding_screens/willing_to_marry_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Samaj { KadvaPatel, LevaPatel }

class SamajScreen extends StatefulWidget {
  final bool fromProfile;
  String response;
  SamajScreen({required this.fromProfile, this.response = ''});

  @override
  _SamajScreenState createState() => _SamajScreenState();
}

class _SamajScreenState extends State<SamajScreen> {
  Samaj? _reply;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _reply = Samaj.KadvaPatel;
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
          onPressed: () => Get.back(),
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
              'Select Your Samaj',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Samaj.KadvaPatel;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Samaj.KadvaPatel,
                    groupValue: _reply,
                    onChanged: (Samaj? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Kadva Patel'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = Samaj.LevaPatel;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: Samaj.LevaPatel,
                    groupValue: _reply,
                    onChanged: (Samaj? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Leva Patel'),
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
                if (_reply == Samaj.KadvaPatel) {
                  Get.find<GlobalController>().currentAppuser.value.samaj =
                      "Kadva Patel";
                  DataBaseMethods().addUserSamaj("Kadva Patel");
                } else {
                  Get.find<GlobalController>().currentAppuser.value.samaj =
                      "Leva Patel";
                  DataBaseMethods().addUserSamaj("Leva Patel");
                }
                if (widget.fromProfile) {
                  Get.off(EditProfileScreen());
                } else {
                  Get.to(WillingToMarryScreen());
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
