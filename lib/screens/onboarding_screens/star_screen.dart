import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/screens/onboarding_screens/handicapped_screen.dart';
import 'package:chat/screens/onboarding_screens/rashi_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';

class StarScreen extends StatefulWidget {
  late final fromProfile;
  String response;
  StarScreen({required this.fromProfile, this.response = ''});

  @override
  _StarScreenState createState() => _StarScreenState();
}

class _StarScreenState extends State<StarScreen> {
  String? starAns = '';
  List<String> stars = [
    'Ashwini',
    'Bharani',
    'Krittika',
    'Rohini',
    'Mrigashīrsha',
    'Ārdrā',
    'Punarvasu',
    'Pushya',
    'Āshleshā',
    'Magha',
    'Purva or Purva Phalguni',
    'Uttara or Uttara Phalguni',
    'Hasta',
    'Chitra',
    'Svati',
    'Visakha',
    'Anuradha',
    'Jyeshtha',
    'Mula',
    'Purva Ashadha',
    'Uttara Asadha',
    'Sravana',
    'Sravistha or Dhanishta',
    'Shatabhisha or Satataraka',
    'Purva Bhadrapada',
    'Uttara Bhadrapada',
    'Revati',
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
        title: Text(
          'PM',
          style:
              TextStyle(color: Color.fromRGBO(255, 85, 115, 1), fontSize: 24),
        ),
        centerTitle: true,
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
                    Get.to(RashiScreen(
                      fromProfile: false,
                    ));
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
              child: DropdownSearch<String>(
                itemAsString: (item) {
                  return item;
                },
                items: (_, __) {
                  return stars;
                },
                selectedItem: starAns != null && starAns!.isNotEmpty ? starAns : null,
                onChanged: (val) {
                  setState(() {
                    starAns = val ?? '';
                  });
                },
                dropdownBuilder: (context, selectedItem) => Text(
                  selectedItem ?? 'Select',
                  style: TextStyle(
                    color: selectedItem == null ? Colors.grey : Colors.black,
                    fontSize: 18,
                  ),
                ),
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  showSelectedItems: true,
                ),
                // selectedItem: "Brazil"
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
                    final globalController = Get.put(GlobalController());
                    Get.find<GlobalController>().currentAppuser.value.star =
                        starAns;
                    DataBaseMethods().addUserStar(starAns!);
                    // Navigator.pop(context);
                    Get.off(EditProfileScreen());
                  }
                } else {
                  DataBaseMethods().addUserStar(starAns!);
                  Get.to(RashiScreen(
                    fromProfile: false,
                  ));
                }
              },
              child: widget.fromProfile
                  ? Text(
                      'Submit',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    )
                  : Text(
                      'Continue',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(255, 85, 115, 0.89),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
