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
import 'package:quiver/iterables.dart';

class FeedScreenController extends GetxController {
  final globalController = Get.put(GlobalController());
  final temp = 0.obs;

  final userListLength = 0.obs;
  int currentPageIndex = 0;
  String gender = '';
  int tmp = 0;
  List<UserModel> usersList = <UserModel>[];
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

  int fnTerminate = 0;

  final currentIndex = 0.obs;

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
    });
    Query<Map<String, dynamic>> query;

    if (globalController.currentAppuser.value.excludedUsers?.length == 0) {
      query = firebaseFirestore
          .collection("users")
          .where("gender", isEqualTo: gender == "Female" ? "Male" : "Female")
          .orderBy("createdAt", descending: true);
    } else {
      query = firebaseFirestore
          .collection("users")
          .where("gender", isEqualTo: gender == "Female" ? "Male" : "Female")
          // .where("uid",
          //     whereNotIn: globalController.currentAppuser.value.excludedUsers)
          // .orderBy("uid")
          .orderBy("createdAt", descending: true);
    }

    print("___________________");
    print(usersList.length == 0 && fnTerminate == 1 && !hasMoreData);
    print("usersList.length = ${usersList.length}");
    print("Function terminate: $fnTerminate");
    print("Has More data : $hasMoreData");
    

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
          print("This is last user data");
          print(lastUser?.data());
          currentItemLength = currentItemLength + snapshot.docs.length;
          print("Snapshot length: ");
          print(snapshot.docs.length);
          if (snapshot.docs.length < itemLimit) {
            print("Here it does hasmoredata false");
            hasMoreData = false;
          }
        }
      });
    }
    usersList.addAll(tmpUsersList);
    if (usersList.length < 5 && hasMoreData) {
      getUsers();
    }
    if (usersList.length == 0 && fnTerminate == 1 && !hasMoreData) {
      print("Here it enter in terminate condition");
      endUser.value = true;
      return;
    }
    print("Loop Starts");
    for (int i = 0; i < usersList.length; i++) {
      print(usersList[i].username);
    }
    print("Loop End");
    isLoadingMoreData = false;
    fnTerminate = 1;
    update();
    stopwatch.stop();
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


// if (usersList.length == 0 && fnTerminate == 1) {
    //   print("Here it enter in terminate condition");
    //   endUser.value = true;
    //   return;
    // }





 // if (globalController.currentAppuser.value.excludedUsers?.length ==
            //         0 ||
            //     !globalController.currentAppuser.value.excludedUsers!
            //         .contains(element.data()['uid'])) {
              // tmpUsersList.add(UserModel.fromJson(element.data()));
              // tmpUsersUid.add(element.data()['uid']);}


              // if (usersList.length < 5 && hasMoreData) {
    //   print("Here length: _________");
    //   print(usersList.length);
    //   getUsers();
    // }