import 'package:chat/controllers/feed_screen_controller.dart';
import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/widgets/bookay_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class FeedButton extends StatelessWidget {
  final int index;
  final String otherUsername;
  final String otherImageUrl;
  final String otherUserId;
  FeedButton(
      {required this.index,
      required this.otherUsername,
      required this.otherImageUrl,
      required this.otherUserId});
  final feedScreenController = Get.put(FeedScreenController());
  final globalController = Get.put(GlobalController());
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return BookayDialogue(
                    index: index,
                    otherUsername: otherUsername,
                    otherImageUrl: otherImageUrl,
                    otherUserId: otherUserId);
              },
            );
          },
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 71, 104, 1),
                      Color.fromRGBO(255, 115, 140, 1)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image(
                  image: AssetImage('assets/bokay.png'),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
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
                onPressed: () {
                  print(
                      'This is userslist length : ${feedScreenController.usersList.length}');
                  print('Here its index ${index + 1}');
                  if (index + 1 == feedScreenController.usersList.length) {
                    feedScreenController.endUser.value = true;
                  }
                  Get.find<FeedScreenController>()
                      .scrollController
                      .scrollToIndex(index + 1,
                          preferPosition: AutoScrollPosition.begin);

                  DataBaseMethods()
                      .addDeclineMethod(otherUserId, otherUsername);
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
                onPressed: () {
                  print(
                      'This is userslist length : ${feedScreenController.usersList.length}');
                  print('Here its index ${index + 1}');
                  if (index + 1 == feedScreenController.usersList.length) {
                    feedScreenController.endUser.value = true;
                  }
                  Get.find<FeedScreenController>()
                      .scrollController
                      .scrollToIndex(index + 1,
                          preferPosition: AutoScrollPosition.begin);
                  DataBaseMethods().addRequestMethod(
                      globalController.currentAppuser.value.username!,
                      otherUsername,
                      otherImageUrl,
                      otherUserId,
                      0);
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
