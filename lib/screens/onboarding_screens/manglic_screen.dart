import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/screens/custom_tab_bar.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/screens/feed_screen.dart';
import 'package:chat/screens/onboarding_screens/handicapped_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum YesNo { Yes, No }

class ManglicScreen extends StatefulWidget {
  final bool fromProfile;
  String response;
  ManglicScreen({required this.fromProfile, this.response = ''});

  @override
  _ManglicScreenState createState() => _ManglicScreenState();
}

class _ManglicScreenState extends State<ManglicScreen> {
  YesNo? _reply;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.response == 'Yes') {
      setState(() {
        _reply = YesNo.Yes;
      });
    } else if (widget.response == 'No') {
      setState(() {
        _reply = YesNo.No;
      });
    } else {
      setState(() {
        _reply = YesNo.No;
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
          onPressed: () => Get.back(),
        ),
        title: Text('PM', style: TextStyle(color: Color.fromRGBO(255, 85, 115, 1), fontSize: 24),),
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
                  onPressed: () async {
                    await DataBaseMethods().addUserManglik('');
                    Get.to(CustomTabBar());
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
              'Are You Manglik?',
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
                  _reply = YesNo.No;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: YesNo.No,
                    groupValue: _reply,
                    onChanged: (YesNo? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('No'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = YesNo.Yes;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: YesNo.Yes,
                    groupValue: _reply,
                    onChanged: (YesNo? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Yes'),
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
              onPressed: () async {
                if (_reply == YesNo.No) {
                  if (widget.fromProfile) {
                    final globalController = Get.put(GlobalController());
                    Get.find<GlobalController>().currentAppuser.value.manglik =
                        "No";
                  }
                  await DataBaseMethods().addUserManglik("No");
                } else {
                  if (widget.fromProfile) {
                    final globalController = Get.put(GlobalController());
                    Get.find<GlobalController>().currentAppuser.value.manglik =
                        "Yes";
                  }
                  await DataBaseMethods().addUserManglik("Yes");
                }
                if (widget.fromProfile) {
                  // Navigator.pop(context);
                    Get.off(EditProfileScreen());
                } else {
                  Get.offAll(CustomTabBar(), );
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
