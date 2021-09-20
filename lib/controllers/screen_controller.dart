import 'package:chat/helper/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenController extends GetxController {
  final selectedPage = 0.obs;
  final userProfileUrl = ''.obs;

  void changePage(int pageNum) {
    selectedPage.value = pageNum;
  }

  fetchUserImage() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final firestore = FirebaseFirestore.instance;
    print('Init State');
    firestore.collection("users").doc(user!.uid).get().then((val) {
      Constants.userImage = val['imgUrls'][0];
      userProfileUrl.value = val['imgUrls'][0];
    });
  }

  @override
  void onInit() {
    fetchUserImage();
    super.onInit();
  }
}
