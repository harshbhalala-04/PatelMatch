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
                showSearchBox: true,
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
