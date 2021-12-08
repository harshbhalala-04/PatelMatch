import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenController extends GetxController {
  final selectedPage = 0.obs;
  final userProfileUrl = ''.obs;
  final isInternet = false.obs;
  final isLoading = false.obs;

  void changePage(int pageNum) {
    selectedPage.value = pageNum;
  }

  fetchUserImage() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final firestore = FirebaseFirestore.instance;
    print('Init State');
    firestore.collection("users").doc(user!.uid).get().then((val) {
      // Constants.userImage = val['imgUrls'][0];
      userProfileUrl.value = val['imgUrls'][0];
    });
  }

  checkInternetConnectivity() async {
    isLoading.toggle();
    var result = await Connectivity().checkConnectivity();
    print("Here inside check internet connect");
    if (result == ConnectivityResult.none) {
      isInternet.value = false;
      print("_____________________________");
      print("Here is internet value: ${isInternet.value}");
    } else {
      isInternet.value = true;
      print("__________________________");
      print("Here is internet value: ${isInternet.value}");
    }
    isLoading.toggle();
  }

  @override
  void onInit() {
    // _checkInternetConnectivity();
    fetchUserImage();
    super.onInit();
  }
}
