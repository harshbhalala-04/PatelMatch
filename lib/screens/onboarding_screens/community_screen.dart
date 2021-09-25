import 'package:chat/controllers/onboarding_screen_controller/community_controller.dart';
import 'package:chat/screens/custom_tab_bar.dart';
import 'package:chat/screens/edit_profile_screen.dart';
import 'package:chat/screens/chat_section/home_screen.dart';
import 'package:chat/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class CommunityScreen extends StatefulWidget {
  late final fromProfile;

  CommunityScreen({required this.fromProfile});

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final communityController = Get.put(CommunityController());
  List<DropdownMenuItem<String>> communities = [
    DropdownMenuItem(
      value: "Community 1",
      child: Text('Community 1'),
    ),
    DropdownMenuItem(
      value: "Community 2",
      child: Text('Community 2'),
    ),
    DropdownMenuItem(
      value: "Community 3",
      child: Text('Community 3'),
    ),
    DropdownMenuItem(
      value: "Community 4",
      child: Text('Community 4'),
    ),
    DropdownMenuItem(
      value: "Community 5",
      child: Text('Community 5'),
    ),
  ];

  @override
  void initState() {
    communityController.fetchUserCommunity();
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
              ? Container(
                  height: 0,
                )
              : TextButton(
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    DataBaseMethods().addUserCommunity('');
                    Get.offAll(CustomTabBar());
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
              height: 20,
            ),
            Text(
              'Community',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Which community do you belong to?'),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: SearchableDropdown.single(
                displayClearIcon: false,
                isExpanded: true,
                hint: communityController.reply.value == ''
                    ? Text(
                        'Select',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )
                    : Obx(
                        () => Text(
                          communityController.reply.value,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                items: communities,
                onChanged: (val) {
                  communityController.changeCommunity(val);
                },
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
                if (communityController.reply.value.isEmpty) {
                  
                  communityController.showCustomDialog();
                } else {
                  DataBaseMethods()
                      .addUserCommunity(communityController.reply.value);

                  if (widget.fromProfile) {
                    Navigator.pop(context);
                    Navigator.popAndPushNamed(
                        context, EditProfileScreen.routeName);
                  } else {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => HomeScreen()));
                    Get.offAll(CustomTabBar());
                  }
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
