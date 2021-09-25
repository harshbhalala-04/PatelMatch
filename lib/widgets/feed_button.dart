import 'package:chat/controllers/feed_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedButton extends StatelessWidget {
  final feedScreenController = Get.put(FeedScreenController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {},
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 15,
            ),
            Container(
              width: 130,
              height: 45,
              child: FloatingActionButton(
                onPressed: () {
                  feedScreenController.currentIndex.value += 1;
                  if (feedScreenController.currentIndex.value >=
                      feedScreenController.userListLength.value) {
                    feedScreenController.currentIndex.value = 0;
                  }
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
                  feedScreenController.currentIndex.value += 1;
                  if (feedScreenController.currentIndex.value >=
                      feedScreenController.userListLength.value) {
                    feedScreenController.currentIndex.value = 0;
                  }
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
