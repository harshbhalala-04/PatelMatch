import 'package:chat/controllers/bookay_controller.dart';
import 'package:chat/controllers/feed_screen_controller.dart';
import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/screens/SubscriptionScreen.dart';
import 'package:chat/screens/custom_tab_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class BookayDialogue extends StatelessWidget {
  TextEditingController textEditingController = new TextEditingController();
  final globalController = Get.put(GlobalController());
  final feedScreenController = Get.put(FeedScreenController());

  final int index;
  final bool fromDynamicLink;
  final String otherUsername;
  final String otherImageUrl;
  final String otherUserId;
  BookayDialogue(
      {required this.index,
      required this.fromDynamicLink,
      required this.otherUsername,
      required this.otherImageUrl,
      required this.otherUserId});
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(user!.uid)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          Map<String, dynamic> myMap = snapshot.data!.data()!;
          print('Bookay value : ${myMap['bookayAvailable']}');
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(SubscriptionScreen());
                          },
                          child: Text(
                            'Buy bouquets',
                            style: TextStyle(fontSize: 14),
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: 65,
                      height: 65,
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          blurRadius: 5,
                        ),
                      ]),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Image(
                          width: 50,
                          height: 50,
                          image: AssetImage(
                            'assets/bokay.png',
                          ),
                          color: Color.fromRGBO(255, 85, 115, 1),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "My bouquets:${myMap['bookayAvailable'].toString()}  "),
                        Transform.rotate(
                          angle: 0.2,
                          child: Image.asset(
                            'assets/bokay.png',
                            color: Colors.pink,
                            width: 15,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Enter the number of bouquets',
                      style: TextStyle(fontSize: 18),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "you want to send ",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        TextSpan(
                          text: otherUsername,
                          style: TextStyle(
                            color: Color.fromRGBO(255, 85, 115, 1),
                            fontSize: 18,
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 45,
                      child: TextFormField(
                        controller: textEditingController,
                        textAlign: TextAlign.center,
                        cursorHeight: 30,
                        cursorColor: Colors.grey,
                        style: TextStyle(
                          fontSize: 24,
                        ),
                        decoration: InputDecoration(
                          hintText: "00",
                          hintStyle: TextStyle(fontSize: 24),
                        ),
                        onSaved: (value) {
                          textEditingController.text = value!;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 175,
                      child: ElevatedButton(
                        onPressed: () {
                          if (int.parse(textEditingController.text) >
                              myMap['bookayAvailable']) {
                            Get.snackbar("You Haven't Enough Bouquets",
                                "Buy More Bouquets",
                                snackPosition: SnackPosition.TOP);
                          } else {
                            // if (index + 1 ==
                            //     feedScreenController.usersList.length) {
                            //   feedScreenController.endUser.value = true;
                            // }
                            Get.find<FeedScreenController>()
                                .scrollController
                                .scrollToIndex(index + 1,
                                    preferPosition: AutoScrollPosition.begin);
                            DataBaseMethods().addRequestMethod(
                                globalController.currentAppuser.value.username!,
                                otherUsername,
                                otherImageUrl,
                                otherUserId,
                                int.parse(textEditingController.text));
                            if (fromDynamicLink) {
                              Get.offAll(CustomTabBar());
                            } else {
                              Navigator.of(context).pop();
                            }
                          }
                        },
                        child: Text(
                          'Send',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.pink.shade400,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'By clicking on “Send” you will send bouquets along with a “Connect” request to the user.',
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
