import 'package:chat/controllers/global_controller.dart';
import 'package:chat/helper/services.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/database/database.dart';
import 'package:chat/screens/onboarding_screens/handicapped_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';

class HeightScreen extends StatefulWidget {
  late final fromProfile;
  String response;
  HeightScreen({required this.fromProfile, this.response = ''});

  @override
  _HeightScreenState createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  String? heightAns = '';
  // List<DropdownMenuItem<String>> heights = [
  //   DropdownMenuItem(
  //     value: "4'0\"",
  //     child: Text("4'0\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "4'1\"",
  //     child: Text("4'1\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "4'2\"",
  //     child: Text("4'2\""),
  //   ),
  //   DropdownMenuItem(
  //     value:"4'3\"",
  //     child: Text("4'3\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "4'4\"",
  //     child: Text("4'4\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "4'5\"",
  //     child: Text("4'5\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "4'6\"",
  //     child: Text("4'6\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "4'7\"",
  //     child: Text("4'7\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "4'8\"",
  //     child: Text("4'8\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "4'9\"",
  //     child: Text("4'9\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "4'10\"",
  //     child: Text("4'10\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "4'11\"",
  //     child: Text("4'11\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "5'0\"",
  //     child: Text("5'0\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "5'1\"",
  //     child: Text("4'1\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "5'2\"",
  //     child: Text("5'2\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "5'3\"",
  //     child: Text("5'3\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "5'4\"",
  //     child: Text("5'4\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "5'5\"",
  //     child: Text("5'5\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "5'6\"",
  //     child: Text("5'6\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "5'7\"",
  //     child: Text("5'7\""),
  //   ),
  //   DropdownMenuItem(
  //     value:"5'8\"",
  //     child: Text("5'8\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "5'9\"",
  //     child: Text("5'9\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "5'10\"",
  //     child: Text("5'10\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "5'11\"",
  //     child: Text("5'11\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "6'0\"",
  //     child: Text("6'0\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "6'1\"",
  //     child: Text("6'1\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "6'2\"",
  //     child: Text("6'2\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "6'3\"",
  //     child: Text("6'3\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "6'4\"",
  //     child: Text("6'4\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "6'5\"",
  //     child: Text("6'5\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "6'6\"",
  //     child: Text("6'6\""),
  //   ),
  //   DropdownMenuItem(
  //     value: "6'7\"",
  //     child: Text("6'7\""),
  //   ),
  //   DropdownMenuItem(
  //     value:  "6'8\"",
  //     child: Text( "6'8\"",),
  //   ),
  //   DropdownMenuItem(
  //     value:  "6'9\"",
  //     child: Text( "6'9\"",),
  //   ),
  //   DropdownMenuItem(
  //     value:  "6'10\"",
  //     child: Text( "6'10\"",),
  //   ),
  //   DropdownMenuItem(
  //     value:  "6'11\"",
  //     child: Text( "6'11\"",),
  //   ),
  //   DropdownMenuItem(
  //     value: "7'0\"",
  //     child: Text( "7'0\"",),
  //   ),

  // ];

  @override
  void initState() {
    if (widget.response != '') {
      setState(() {
        heightAns = widget.response;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'PM',
          style:
              TextStyle(color: Color.fromRGBO(255, 85, 115, 1), fontSize: 24),
        ),
        centerTitle: true,
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
              'What is your height?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItems: true,
                items: heights,
                // ignore: deprecated_member_use
                label: "Select",
                // popupItemDisabled: (String s) =>
                //     s.startsWith('I'),
                onChanged: (val) {
                  heightAns = val!;
                },
                // selectedItem: "Brazil"
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: ElevatedButton(
              onPressed: () {
                if (widget.fromProfile) {
                  if (heightAns == '') {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Please Select Your Height.'),
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
                    final globalController = Get.put(GlobalController());
                    Get.find<GlobalController>().currentAppuser.value.height =
                        heightAns;
                    DataBaseMethods().addUserHeight(heightAns!);

                    // Navigator.pop(context);
                    Get.off(EditProfileScreen());
                  }
                } else {
                  DataBaseMethods().addUserHeight(heightAns!);
                  Get.to(HandicappedScreen(
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
