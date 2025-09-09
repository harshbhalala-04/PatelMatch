import 'package:chat/controllers/global_controller.dart';
import 'package:chat/controllers/request_screen_controller.dart';
import 'package:chat/controllers/show_profile_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/widgets/build_stacked_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AcceptDialogue extends StatelessWidget {
  final String userProfile;
  final String otherUserProfile;
  final String uid;
  final int profileType;

  AcceptDialogue({
    required this.userProfile,
    required this.otherUserProfile,
    required this.uid,
    required this.profileType,
  });

  TextEditingController textEditingController = new TextEditingController();
  final requestScreenController = Get.put(RequestScreenController());
  final showProfileScreenController = Get.put(ShowProfileController());
  String myUsername =
      Get.find<GlobalController>().currentAppuser.value.username!;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: AlertDialog(
        scrollable: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              buildStackedImages(direction: TextDirection.ltr),
              SizedBox(
                height: 5,
              ),
              Text(
                'Accept the request and strike ',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              Text(
                'up a conversation!',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 200,
                child: TextFormField(
                  controller: textEditingController,
                  textAlign: TextAlign.start,
                  cursorHeight: 14,
                  cursorColor: Colors.grey,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: "Write your first message...",
                    hintStyle: TextStyle(fontSize: 14),
                  ),
                  onSaved: (value) {
                    textEditingController.text = value!;
                  },
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    if (textEditingController.text.isEmpty) {
                      Get.snackbar("Please Enter Some Message", "",
                          snackPosition: SnackPosition.BOTTOM);
                    } else {
                      requestScreenController.removeUser(uid, profileType);
                      Get.back();
                      Get.back();
                      showProfileScreenController.createChatRoom();
                      showProfileScreenController
                          .addMessage(textEditingController.text);
                      DataBaseMethods().removeUserFromFriendRequest(
                          showProfileScreenController.currentUser.value.uid!,
                          Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .uid!);
                      DataBaseMethods().addUserToMatch(
                          myUsername,
                          userProfile,
                          showProfileScreenController
                              .currentUser.value.username!,
                          otherUserProfile,
                          showProfileScreenController.currentUser.value.uid!);
                    }
                  },
                  child: Text(
                    'Accept',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'By clicking on “Accept” you will accept the request and send a message.',
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStackedImages({
    TextDirection direction = TextDirection.rtl,
  }) {
    final double size = 70;
    final double xShift = 20;
    final urlImages = [userProfile, otherUserProfile];

    final items = urlImages.map((urlImage) => buildImage(urlImage)).toList();

    return StackedProfiles(
      direction: direction,
      items: items,
      size: size,
      xShift: xShift,
    );
  }

  Widget buildImage(String urlImage) {
    final double borderSize = 5;

    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(borderSize),
        color: Colors.white,
        child: ClipOval(
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
