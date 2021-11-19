import 'package:chat/controllers/feed_screen_controller.dart';
import 'package:chat/controllers/request_screen_controller.dart';
import 'package:chat/screens/single_user_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestScreen extends StatefulWidget {
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  bool isSent = false;
  List<dynamic> profiles = [];
  List<String> userIds = [];
  bool isLoading = false;
  List<Map<String, dynamic>> profileData = [];
  final requestScreenController = Get.put(RequestScreenController());

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            body: Obx(() => requestScreenController.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Obx(() => SingleUserRequest(
                    profiles: requestScreenController.profiles.value,
                    specialProfiles:
                        requestScreenController.specialProfiles.value))));
  }
}
