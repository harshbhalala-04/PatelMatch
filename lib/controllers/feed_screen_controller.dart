import 'dart:math';

import 'package:chat/controllers/filter_controller.dart';
import 'package:chat/controllers/global_controller.dart';
import 'package:chat/global.dart';
import 'package:chat/helper/constants.dart';
import 'package:chat/helper/user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class FeedScreenController extends GetxController {
  final globalController = Get.put(GlobalController());
  final temp = 0.obs;
  final currentIndex = 0.obs;
  final potentialUsersList = <UserModel>[].obs;
  final userListLength = 0.obs;
  int currentPageIndex = 0;
  String gender = '';
  int tmp = 0;
  List<UserModel> usersList = <UserModel>[];
  final AutoScrollController scrollController = AutoScrollController();

  final isFilterApplied = false.obs;
  final friendRequestList = [].obs;
  int currentItemLength = 0;
  int previousItemLength = 0;

  DocumentSnapshot? lastUser;
  bool isLoadingMoreData = false;

  final FirebaseAuth? auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;

  final endUser = false.obs;

  List<String> rashi = [
    "Aries",
    "Taurus",
    "Gemini",
    "Cancer",
    "Leo",
    "Virgo",
    "Libra",
    "Scorpio",
    "Saggitarius",
    "Capricorn",
    "Aquarius",
    "Pisces"
  ];

  void scrollListener() {
    if (scrollController.offset >=
            scrollController.position.maxScrollExtent - 100 &&
        !scrollController.position.outOfRange) {
      if (previousItemLength != currentItemLength) {
        previousItemLength = currentItemLength;
        getUsers();
      }
    }
  }

  int itemLimit = 5;
  bool hasMoreData = true;

  getUsers() async {
    final stopwatch = Stopwatch()..start();
    List<UserModel> tmpUsersList = <UserModel>[];
    await firestore.collection("users").doc(user!.uid).get().then((val) {
      Map<String, dynamic> tmpMap = val.data()!;
      gender = tmpMap['gender'];
      isFilterApplied.value = tmpMap['isFilterApplied'];
      // if (tmpMap.containsKey('friendRequest')) {
      //   // friendRequestList.value = tmpMap['friendRequest'];
      // }
    });
    // print("From get users : $friendRequestList");
    Query<Map<String, dynamic>> query;

    query = firebaseFirestore
        .collection("users")
        .where("gender", isEqualTo: gender == "Female" ? "Male" : "Female")
        // .orderBy("friendRequest")
        .orderBy("createdAt", descending: true);

    if (lastUser != null) {
      isLoadingMoreData = true;
      query = query.startAfterDocument(lastUser!);
    }

    query = query.limit(itemLimit);
    // print("Friend Request: ${friendRequestList[0]['id']}");
    // print("Friend Request: ${friendRequestList[1]['id']}");

    if (hasMoreData) {
      await query.get().then((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          snapshot.docs.forEach((element) {
            // int flag = 0;
            // for (int i = 0; i < friendRequestList.length; i++) {
            //   if (friendRequestList[i]['id'] == element.data()['uid']) {
            //     flag = 1;
            //   }
            // }
            // if (flag == 0) {
              tmpUsersList.add(UserModel.fromJson(element.data()));
            // }
          });
          lastUser = snapshot.docs[snapshot.docs.length - 1];
          currentItemLength = currentItemLength + snapshot.docs.length;
          if (snapshot.docs.length < itemLimit) {
            hasMoreData = false;
          }
        }
      });
    }

    usersList.addAll(tmpUsersList);

    isLoadingMoreData = false;
    update();
    stopwatch.stop();
    // print('doSomething() executed in ${stopwatch.elapsed}');
  }

  @override
  void onInit() {
    scrollController.addListener(scrollListener);
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
