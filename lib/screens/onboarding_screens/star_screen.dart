import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/screens/onboarding_screens/handicapped_screen.dart';
import 'package:chat/screens/onboarding_screens/rashi_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class StarScreen extends StatefulWidget {
  late final fromProfile;
  String response;
  StarScreen({required this.fromProfile, this.response = ''});

  @override
  _StarScreenState createState() => _StarScreenState();
}

class _StarScreenState extends State<StarScreen> {
  String? starAns = '';
  List<DropdownMenuItem<String>> stars = [
    DropdownMenuItem(
      value: "Ashwini",
      child: Text('Ashwini'),
    ),
    DropdownMenuItem(
      value: "Bharani",
      child: Text('Bharani'),
    ),
    DropdownMenuItem(
      value: "Krittika",
      child: Text('Krittika'),
    ),
    DropdownMenuItem(
      value: "Rohini",
      child: Text('Rohini'),
    ),
    DropdownMenuItem(
      value: "Mrigashirsha",
      child: Text('Mrigashīrsha'),
    ),
    DropdownMenuItem(
      value: "Ardra",
      child: Text('Ārdrā'),
    ),
    DropdownMenuItem(
      value: "Punarvasu",
      child: Text('Punarvasu'),
    ),
    DropdownMenuItem(
      value: "Pushya",
      child: Text('Pushya'),
    ),
    DropdownMenuItem(
      value: "Āshleshā",
      child: Text('Āshleshā'),
    ),
    DropdownMenuItem(
      value: "Magha",
      child: Text('Magha'),
    ),
    DropdownMenuItem(
      value: "Purva or Purva Phalguni",
      child: Text('Purva or Purva Phalguni'),
    ),
    DropdownMenuItem(
      value: "Uttara or Uttara Phalguni",
      child: Text('Uttara or Uttara Phalguni'),
    ),
    DropdownMenuItem(
      value: "Hasta",
      child: Text('Hasta'),
    ),
    DropdownMenuItem(
      value: "Chitra",
      child: Text('Chitra'),
    ),
    DropdownMenuItem(
      value: "Svati",
      child: Text('Svati'),
    ),
    DropdownMenuItem(
      value: "Visakha",
      child: Text('Visakha'),
    ),
    DropdownMenuItem(
      value: "Anuradha",
      child: Text('Anuradha'),
    ),
    DropdownMenuItem(
      value: "Jyeshtha",
      child: Text('Jyeshtha'),
    ),
    DropdownMenuItem(
      value: "Mula",
      child: Text('Mula'),
    ),
    DropdownMenuItem(
      value: "Purva Ashadha",
      child: Text('Purva Ashadha'),
    ),
    DropdownMenuItem(
      value: "Uttara Asadha",
      child: Text('Uttara Asadha'),
    ),
    DropdownMenuItem(
      value: "Sravana",
      child: Text('Sravana'),
    ),
    DropdownMenuItem(
      value: "Sravistha or Dhanishta",
      child: Text('Sravistha or Dhanishta'),
    ),
    DropdownMenuItem(
      value: "Shatabhisha or Satataraka",
      child: Text('Shatabhisha or Satataraka'),
    ),
    DropdownMenuItem(
      value: "Purva Bhadrapada",
      child: Text('Purva Bhadrapada'),
    ),
    DropdownMenuItem(
      value: "Uttara Bhadrapada",
      child: Text('Uttara Bhadrapada'),
    ),
    DropdownMenuItem(
      value: "Revati",
      child: Text('Revati'),
    ),
  ];

  @override
  void initState() {
    if (widget.response != '') {
      setState(() {
        starAns = widget.response;
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
        actions: [
          widget.fromProfile
              ? Container()
              : TextButton(
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    DataBaseMethods().addUserStar('');
                    Get.to(RashiScreen(fromProfile: false,));
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
              'Select Your Star.',
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
                hint: starAns == ''
                    ? Text(
                        'Select',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )
                    : Text(
                        starAns!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                isExpanded: true,
                items: stars,
                //value: heightAns == '' ? Text('') : Text(heightAns!),
                onChanged: (val) {
                  starAns = val;
                  print(starAns);
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
                  if (starAns == null) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Please Select Your Star.'),
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
                    Get.find<GlobalController>().currentAppuser.value.star =
                        starAns;
                    DataBaseMethods().addUserStar(starAns!);
                    Get.off(EditProfileScreen());
                  }
                } else {
                  DataBaseMethods().addUserStar(starAns!);
                  Get.to(RashiScreen(fromProfile: false,));
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
