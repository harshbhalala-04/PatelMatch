import 'package:chat/controllers/global_controller.dart';
import 'package:chat/controllers/request_screen_controller.dart';
import 'package:chat/controllers/screen_controller.dart';
import 'package:chat/controllers/show_profile_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/screens/custom_tab_bar.dart';
import 'package:chat/screens/nested_tab/request_tab.dart';
import 'package:chat/screens/request_screen.dart';
import 'package:chat/widgets/accept_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileFeedButton extends StatelessWidget {
  final String uid;
  final int profileType;

  ProfileFeedButton({
    required this.profileType,
    required this.uid,
  });

  final requestScreenController = Get.put(RequestScreenController());
  final showProfileController = Get.put(ShowProfileController());

  @override
  Widget build(BuildContext context) {
   
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 70,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 15,
            ),
            Container(
              width: 130,
              height: 45,
              child: FloatingActionButton(
                heroTag: 'DeclineButton2',
                onPressed: () {
                  DataBaseMethods().declineRequest(uid);
                  requestScreenController.removeUser(uid, profileType);
                  Get.back();
                },
                child: Text(
                  'Decline',
                  style: TextStyle(
                      fontSize: 18, color: Color.fromRGBO(184, 184, 184, 1)),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 130,
              height: 45,
              child: FloatingActionButton(
                heroTag: 'ConnectButton2',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AcceptDialogue(
                        userProfile: Get.find<GlobalController>()
                            .currentAppuser
                            .value
                            .imgUrl!,
                        otherUserProfile:
                            showProfileController.currentUser.value.imgUrl!,
                        uid: uid,
                        profileType: profileType,
                      );
                    },
                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(255, 71, 104, 1),
                        Color.fromRGBO(255, 115, 140, 1)
                      ]),
                      borderRadius: BorderRadius.circular(50)),
                  child: Container(
                    width: 130,
                    height: 45,
                    alignment: Alignment.center,
                    child: Text(
                      'Connect',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
