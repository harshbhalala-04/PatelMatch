import 'package:chat/controllers/global_controller.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/database/database.dart';
import 'package:chat/screens/onboarding_screens/handicapped_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class HeightScreen extends StatefulWidget {
  late final fromProfile;
  String response;
  HeightScreen({required this.fromProfile, this.response = ''});

  @override
  _HeightScreenState createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  String? heightAns = '';
  List<DropdownMenuItem<String>> heights = [
    DropdownMenuItem(
      value: "4 ft",
      child: Text('4 ft'),
    ),
    DropdownMenuItem(
      value: "4.04 ft",
      child: Text('4.04 ft'),
    ),
    DropdownMenuItem(
      value: "4.07 ft",
      child: Text('4.07 ft'),
    ),
    DropdownMenuItem(
      value: "4.1 ft",
      child: Text('4.1 ft'),
    ),
    DropdownMenuItem(
      value: "4.13 ft",
      child: Text('4.13 ft'),
    ),
    DropdownMenuItem(
      value: "4.17 ft",
      child: Text('4.17 ft'),
    ),
    DropdownMenuItem(
      value: "4.2 ft",
      child: Text('4.2 ft'),
    ),
    DropdownMenuItem(
      value: "4.23 ft",
      child: Text('4.23 ft'),
    ),
    DropdownMenuItem(
      value: "4.27 ft",
      child: Text('4.27 ft'),
    ),
    DropdownMenuItem(
      value: "4.3 ft",
      child: Text('4.3 ft'),
    ),
    DropdownMenuItem(
      value: "4.33 ft",
      child: Text('4.33 ft'),
    ),
    DropdownMenuItem(
      value: "4.36 ft",
      child: Text('4.36 ft'),
    ),
    DropdownMenuItem(
      value: "4.4 ft",
      child: Text('4.4 ft'),
    ),
    DropdownMenuItem(
      value: "4.43 ft",
      child: Text('4.43 ft'),
    ),
    DropdownMenuItem(
      value: "4.46 ft",
      child: Text('4.46 ft'),
    ),
    DropdownMenuItem(
      value: "4.49 ft",
      child: Text('4.49 ft'),
    ),
    DropdownMenuItem(
      value: "4.53 ft",
      child: Text('4.53 ft'),
    ),
    DropdownMenuItem(
      value: "4.56 ft",
      child: Text('4.56 ft'),
    ),
    DropdownMenuItem(
      value: "4.59 ft",
      child: Text('4.59 ft'),
    ),
    DropdownMenuItem(
      value: "4.63 ft",
      child: Text('4.63 ft'),
    ),
    DropdownMenuItem(
      value: "4.66 ft",
      child: Text('4.66 ft'),
    ),
    DropdownMenuItem(
      value: "4.69 ft",
      child: Text('4.69 ft'),
    ),
    DropdownMenuItem(
      value: "4.72 ft",
      child: Text('4.72 ft'),
    ),
    DropdownMenuItem(
      value: "4.76 ft",
      child: Text('4.76 ft'),
    ),
    DropdownMenuItem(
      value: "4.79 ft",
      child: Text('4.79 ft'),
    ),
    DropdownMenuItem(
      value: "4.82 ft",
      child: Text('4.82 ft'),
    ),
    DropdownMenuItem(
      value: "4.86 ft",
      child: Text('4.86 ft'),
    ),
    DropdownMenuItem(
      value: "4.89 ft",
      child: Text('4.89 ft'),
    ),
    DropdownMenuItem(
      value: "4.92 ft",
      child: Text('4.92 ft'),
    ),
    DropdownMenuItem(
      value: "4.95 ft",
      child: Text('4.95 ft'),
    ),
    DropdownMenuItem(
      value: "4.99 ft",
      child: Text('4.99 ft'),
    ),
    DropdownMenuItem(
      value: "5.02 ft",
      child: Text('5.02 ft'),
    ),
    DropdownMenuItem(
      value: "5.05 ft",
      child: Text('5.05 ft'),
    ),
    DropdownMenuItem(
      value: "5.09 ft",
      child: Text('5.09 ft'),
    ),
    DropdownMenuItem(
      value: "5.12 ft",
      child: Text('5.12 ft'),
    ),
    DropdownMenuItem(
      value: "5.15 ft",
      child: Text('5.15 ft'),
    ),
    DropdownMenuItem(
      value: "5.18 ft",
      child: Text('5.18 ft'),
    ),
    DropdownMenuItem(
      value: "5.22 ft",
      child: Text('5.22 ft'),
    ),
    DropdownMenuItem(
      value: "5.25 ft",
      child: Text('5.25 ft'),
    ),
    DropdownMenuItem(
      value: "5.28 ft",
      child: Text('5.28 ft'),
    ),
    DropdownMenuItem(
      value: "5.31 ft",
      child: Text('5.31 ft'),
    ),
    DropdownMenuItem(
      value: "5.35 ft",
      child: Text('5.35 ft'),
    ),
    DropdownMenuItem(
      value: "5.38 ft",
      child: Text('5.38 ft'),
    ),
    DropdownMenuItem(
      value: "5.41 ft",
      child: Text('5.41 ft'),
    ),
    DropdownMenuItem(
      value: "5.45 ft",
      child: Text('5.45 ft'),
    ),
    DropdownMenuItem(
      value: "5.48 ft",
      child: Text('5.48 ft'),
    ),
    DropdownMenuItem(
      value: "5.51 ft",
      child: Text('5.51 ft'),
    ),
    DropdownMenuItem(
      value: "5.54 ft",
      child: Text('5.54 ft'),
    ),
    DropdownMenuItem(
      value: "5.58 ft",
      child: Text('5.58 ft'),
    ),
    DropdownMenuItem(
      value: "5.61 ft",
      child: Text('5.61 ft'),
    ),
    DropdownMenuItem(
      value: "5.64 ft",
      child: Text('5.64 ft'),
    ),
    DropdownMenuItem(
      value: "5.68 ft",
      child: Text('5.68 ft'),
    ),
    DropdownMenuItem(
      value: "5.71 ft",
      child: Text('5.71 ft'),
    ),
    DropdownMenuItem(
      value: "5.74 ft",
      child: Text('5.74 ft'),
    ),
    DropdownMenuItem(
      value: "5.78 ft",
      child: Text('5.78 ft'),
    ),
    DropdownMenuItem(
      value: "5.81 ft",
      child: Text('5.81 ft'),
    ),
    DropdownMenuItem(
      value: "5.84 ft",
      child: Text('5.84 ft'),
    ),
    DropdownMenuItem(
      value: "5.87 ft",
      child: Text('5.87 ft'),
    ),
    DropdownMenuItem(
      value: "5.91 ft",
      child: Text('5.91 ft'),
    ),
    DropdownMenuItem(
      value: "5.94 ft",
      child: Text('5.94 ft'),
    ),
    DropdownMenuItem(
      value: "5.97 ft",
      child: Text('5.97 ft'),
    ),
    DropdownMenuItem(
      value: "6.0 ft",
      child: Text('6.0 ft'),
    ),
    DropdownMenuItem(
      value: "6.04 ft",
      child: Text('6.04 ft'),
    ),
    DropdownMenuItem(
      value: "6.07 ft",
      child: Text('6.07 ft'),
    ),
    DropdownMenuItem(
      value: "6.1 ft",
      child: Text('6.1 ft'),
    ),
    DropdownMenuItem(
      value: "6.14 ft",
      child: Text('6.14 ft'),
    ),
    DropdownMenuItem(
      value: "6.17 ft",
      child: Text('6.17 ft'),
    ),
    DropdownMenuItem(
      value: "6.2 ft",
      child: Text('6.2 ft'),
    ),
    DropdownMenuItem(
      value: "6.23 ft",
      child: Text('6.23 ft'),
    ),
    DropdownMenuItem(
      value: "6.27 ft",
      child: Text('6.27 ft'),
    ),
    DropdownMenuItem(
      value: "6.3 ft",
      child: Text('6.3 ft'),
    ),
    DropdownMenuItem(
      value: "6.33 ft",
      child: Text('6.33 ft'),
    ),
    DropdownMenuItem(
      value: "6.36 ft",
      child: Text('6.36 ft'),
    ),
    DropdownMenuItem(
      value: "6.4 ft",
      child: Text('6.4 ft'),
    ),
    DropdownMenuItem(
      value: "6.43 ft",
      child: Text('6.43 ft'),
    ),
    DropdownMenuItem(
      value: "6.46 ft",
      child: Text('6.46 ft'),
    ),
    DropdownMenuItem(
      value: "6.5 ft",
      child: Text('6.5 ft'),
    ),
    DropdownMenuItem(
      value: "6.53 ft",
      child: Text('6.53 ft'),
    ),
    DropdownMenuItem(
      value: "6.56 ft",
      child: Text('6.56 ft'),
    ),
    DropdownMenuItem(
      value: "6.59 ft",
      child: Text('6.59 ft'),
    ),
  ];

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
              child: SearchableDropdown.single(
                displayClearIcon: false,
                hint: heightAns == ''
                    ? Text(
                        'Select',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )
                    : Text(
                        heightAns!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                isExpanded: true,
                items: heights,
                //value: heightAns == '' ? Text('') : Text(heightAns!),
                onChanged: (val) {
                  heightAns = val;
                  print(heightAns);
                },
              ),
            ),
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
                  if (heightAns == null) {
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
                    Get.find<GlobalController>().currentAppuser.value.height =
                        heightAns;
                    DataBaseMethods().addUserHeight(heightAns!);
                    
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
