import 'dart:math';

import 'package:chat/controllers/filter_controller.dart';
import 'package:chat/controllers/global_controller.dart';
import 'package:chat/global.dart';
import 'package:chat/helper/user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:quiver/iterables.dart';

class FeedScreenController extends GetxController {
  final globalController = Get.put(GlobalController());

  final userListLength = 0.obs;
  int currentPageIndex = 0;
  String gender = '';
  int tmp = 0;
  List<UserModel> usersList = <UserModel>[].obs;
  final AutoScrollController scrollController = AutoScrollController();

  final isFilterApplied = false.obs;
  final friendRequestList = [].obs;
  List<String> tmpUsersUid = [];
  int currentItemLength = 0;
  int previousItemLength = 0;

  DocumentSnapshot? lastUser;
  bool isLoadingMoreData = false;

  final FirebaseAuth? auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;

  final endUser = false.obs;

  final messageOpenTill = Timestamp.now().obs;

  final freeTrial = false.obs;

  int fnTerminate = 0;

  final currentIndex = 0.obs;

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

  void removeUserFromFeed(String uid) {
    usersList.removeWhere((profile) => profile.uid == uid);
  }

  int itemLimit = 10;
  bool hasMoreData = true;
  final count = 0.obs;

  getUsers() async {
    final stopwatch = Stopwatch()..start();
    List<UserModel> tmpUsersList = <UserModel>[];

    await firestore.collection("users").doc(user!.uid).get().then((val) {
      print(val.data());
      Map<String, dynamic> tmpMap = val.data()!;
      gender = tmpMap['gender'];
      messageOpenTill.value = tmpMap['messageOpenTill'] ?? Timestamp.now();
      freeTrial.value = tmpMap['freeTrial'];
      // globalController.currentAppuser.value.filters.samaj = tmpMap['filters'] 
    });
    Query<Map<String, dynamic>> query;



    if (globalController.currentAppuser.value.excludedUsers?.length == 0) {
      query = firebaseFirestore
          .collection("users")
          .where("gender", isEqualTo: gender == "Female" ? "Male" : "Female")
          .where("isApproved", isEqualTo: true)
          .orderBy("createdAt", descending: true);
    } else {
      query = firebaseFirestore
          .collection("users")
          .where("gender", isEqualTo: gender == "Female" ? "Male" : "Female")
          .where("isApproved", isEqualTo: true)
          .orderBy("createdAt", descending: true);
    }

    if (lastUser != null) {
      isLoadingMoreData = true;
      query = query.startAfterDocument(lastUser!);
    }

    query = query.limit(itemLimit);

    if (hasMoreData) {
      await query.get().then((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          snapshot.docs.forEach((element) {
            if (globalController.currentAppuser.value.excludedUsers?.length ==
                    0 ||
                !globalController.currentAppuser.value.excludedUsers!
                    .contains(element.data()['uid'])) {
              tmpUsersList.add(UserModel.fromJson(element.data()));
              tmpUsersUid.add(element.data()['uid']);
            }
          });
          lastUser = snapshot.docs[snapshot.docs.length - 1];

          currentItemLength = currentItemLength + snapshot.docs.length;

          if (snapshot.docs.length < itemLimit) {
            hasMoreData = false;
          }
        } else {
          hasMoreData = false;
        }
      });
    }

    usersList.addAll(tmpUsersList);

    if (usersList.length < 5 && hasMoreData) {
      getUsers();
    }
    if (usersList.length == 0 && fnTerminate == 1 && !hasMoreData) {
      endUser.value = true;
      return;
    }

    if (usersList.length == 0 && fnTerminate == 0 && !hasMoreData) {
      endUser.value = true;
      return;
    }

    for (int i = 0; i < usersList.length; i++) {
      print(usersList[i].username);
    }
    isLoadingMoreData = false;
    fnTerminate = 1;
    update();
    stopwatch.stop();
  }

  final selectedBookayVal = 1.obs;
 

  @override
  void onInit() {
    scrollController.addListener(scrollListener);
    // getUsers();
    super.onInit();
  }

  @override
  void onClose() {
    // scrollController.dispose();
    super.onClose();
  }
}
