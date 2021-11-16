import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/screens/onboarding_screens/gotra_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../edit_profile_screen.dart';

class RashiScreen extends StatefulWidget {
   late final fromProfile;
  String response;
  RashiScreen({required this.fromProfile, this.response = ''});


  @override
  _RashiScreenState createState() => _RashiScreenState();
}

class _RashiScreenState extends State<RashiScreen> {
  String? rashiAns = '';
  List<DropdownMenuItem<String>> rashis = [
    DropdownMenuItem(
      value: "Aries",
      child: Text('Aries'),
    ),
    DropdownMenuItem(
      value: "Taurus",
      child: Text('Taurus'),
    ),
    DropdownMenuItem(
      value: "Gemini",
      child: Text('Gemini'),
    ),
    DropdownMenuItem(
      value: "Cancer",
      child: Text('Cancer'),
    ),
    DropdownMenuItem(
      value: "Leo",
      child: Text('Leo'),
    ),
    DropdownMenuItem(
      value: "Virgo",
      child: Text('Virgo'),
    ),
    DropdownMenuItem(
      value: "Libra",
      child: Text('Libra'),
    ),
    DropdownMenuItem(
      value: "Scorpio",
      child: Text('Scorpio'),
    ),
    DropdownMenuItem(
      value: "Saggitarius",
      child: Text('Saggitarius'),
    ),
    DropdownMenuItem(
      value: "Capricorn",
      child: Text('Capricorn'),
    ),
    DropdownMenuItem(
      value: "Aquarius",
      child: Text('Aquarius'),
    ),
    DropdownMenuItem(
      value: "Pisces",
      child: Text('Pisces'),
    ),

  ];

  @override
  void initState() {
    if (widget.response != '') {
      setState(() {
        rashiAns = widget.response;
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
        actions: [
          widget.fromProfile ? Container() : TextButton(
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    DataBaseMethods().addUserRashi('');
                    Get.to(GotraScreen(fromProfile: false,));
                  },
                )
        ],
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
              'Select Your Rashi.',
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
                hint: rashiAns == ''
                    ? Text(
                        'Select',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )
                    : Text(
                        rashiAns!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                isExpanded: true,
                items: rashis,
                onChanged: (val) {
                  rashiAns = val;
                  print(rashiAns);
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
                  if (rashiAns == null) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Please Select Your Rashi.'),
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
                    Get.find<GlobalController>().currentAppuser.value.rashi =
                        rashiAns;
                    DataBaseMethods().addUserRashi(rashiAns!);
                    Get.off(EditProfileScreen());
                  }
                } else {
                  DataBaseMethods().addUserRashi(rashiAns!);
                  Get.to(GotraScreen(fromProfile: false,));
                }
              },
              child: widget.fromProfile ?  Text(
                'Submit',
                style: TextStyle(fontSize: 17),
              ):  Text(
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
