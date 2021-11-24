import 'package:chat/controllers/feed_screen_controller.dart';
import 'package:chat/controllers/global_controller.dart';
import 'package:chat/controllers/req_receive_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/helper/user_modal.dart';
import 'package:chat/widgets/build_stacked_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AcceptDialogeFromFeed extends StatelessWidget {
  final UserModel otherUser;
  AcceptDialogeFromFeed({required this.otherUser});

  TextEditingController textEditingController = TextEditingController();
  final reqReceieveController = Get.put(ReqReceiveController());

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
                      // requestScreenController.removeUser(uid, profileType);
                      Get.back();
                      Get.back();
                      reqReceieveController.createChatRoom(otherUser);
                      reqReceieveController
                          .addMessage(textEditingController.text, otherUser);
                      // showProfileScreenController.createChatRoom();
                      // showProfileScreenController
                      //     .addMessage(textEditingController.text);
                      DataBaseMethods().removeUserFromFriendRequest(
                          otherUser.uid!,
                          Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .uid!);
                      Get.find<FeedScreenController>()
                          .removeUserFromFeed(otherUser.uid!);
                      DataBaseMethods().addUserToMatch(
                          Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .username!,
                          Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .imgUrl!,
                          otherUser.username!,
                          otherUser.imgUrl!,
                          otherUser.uid!);
                    }
                  },
                  child: Text(
                    'Accept',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink.shade400,
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
    final urlImages = [
      Get.find<GlobalController>().currentAppuser.value.imgUrl,
      otherUser.imgUrl
    ];

    final items = urlImages.map((urlImage) => buildImage(urlImage!)).toList();

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
