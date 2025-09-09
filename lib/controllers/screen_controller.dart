// ignore_for_file: unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenController extends GetxController {
  final selectedPage = 0.obs;
  final userProfileUrl = ''.obs;
  final isInternet = false.obs;
  final isLoading = false.obs;
  final rejectedUser = false.obs;
  final approvedUser = false.obs;
  final pendingUser = false.obs;
  final isRejected = false.obs;
  final isApproved = false.obs;
  final isAlterNumber = false.obs;
  final userNumber = "".obs;
  void changePage(int pageNum) {
    selectedPage.value = pageNum;
  }

  fetchUserImage() async {
    isLoading.toggle();
    checkInternetConnectivity();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final firestore = FirebaseFirestore.instance;

    await firestore.collection("users").doc(user!.uid).get().then((val) {
      userProfileUrl.value = val['imgUrls'][0];
      userNumber.value = val['phoneNo'];
      isRejected.value = val['isRejected'];
      isApproved.value = val['isApproved'];
      if (!val.data()!.containsKey('alterNumber')) {
        isAlterNumber.value = false;
      } else {
        isAlterNumber.value = true;
      }
      checkUserStatus();
    });
    isLoading.toggle();
  }

  checkUserStatus() {
    print(isRejected);
    print(isApproved);
    if (isRejected.value == false && isApproved.value == false) {
      pendingUser.value = true;
    }
    if (isRejected.value) {
      rejectedUser.value = true;
    }
    if (isApproved.value) {
      approvedUser.value = true;
    }
  }

  checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      isInternet.value = false;
    } else {
      isInternet.value = true;
    }
  }

  @override
  void onInit() {
    fetchUserImage();
    super.onInit();
  }
}
