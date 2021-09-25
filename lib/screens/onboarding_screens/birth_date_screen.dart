import 'package:chat/controllers/onboarding_screen_controller/birth_date_controller.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/screens/onboarding_screens/gender_screen.dart';
import 'package:chat/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BirthDateScreen extends StatelessWidget {
  late final fromProfile;
  BirthDateScreen({required this.fromProfile});
  final birthDateController = Get.put(BirthDateController());  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          fromProfile
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
                    Get.to(GenderScreen(fromProfile: false));
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
                    child: Obx(() => (TextField(
                          onTap: () {
                            birthDateController.showDatePickerDailog(context);
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: birthDateController.dd.value == ''
                                ? "DD"
                                : birthDateController.dd.value,
                            border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 2),
                            ),
                          ),
                        ))),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Flexible(
                    child: Container(
                  width: 60,
                  child: Obx(() => (TextField(
                        onTap: () {
                          birthDateController.showDatePickerDailog(context);
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: birthDateController.mm.value == ''
                              ? "MM"
                              : birthDateController.mm.value,
                          border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 2),
                          ),
                        ),
                      ))),
                )),
                SizedBox(
                  width: 16,
                ),
                Flexible(
                    child: Container(
                  width: 80,
                  child: Obx(() => (TextField(
                        onTap: () {
                          birthDateController.showDatePickerDailog(context);
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: birthDateController.yyyy.value == ''
                              ? "YYYY"
                              : birthDateController.yyyy.value,
                          border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 2),
                          ),
                        ),
                      ))),
                )),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today_rounded),
                  onPressed: () {
                    birthDateController.showDatePickerDailog(context);
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
                if (fromProfile) {
                  if (birthDateController.dd.value == 'DD') {
                    birthDateController.showDialog();
                  } else {
                    String date = birthDateController.dd.value;
                    String month = birthDateController.mm.value;
                    String year = birthDateController.yyyy.value;
                    DataBaseMethods().addUserBirthDate(date, month, year);
                    Navigator.pop(context);
                    Navigator.popAndPushNamed(
                        context, EditProfileScreen.routeName);
                  }
                } else {
                  if (birthDateController.dd.value == 'DD') {
                    birthDateController.showDialog();
                  } else {
                    String date = birthDateController.dd.value;
                    String month = birthDateController.mm.value;
                    String year = birthDateController.yyyy.value;
                    DataBaseMethods().addUserBirthDate(date, month, year);
                    Get.to(GenderScreen(fromProfile: false));
                  }
                }
              },
              child: fromProfile
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
