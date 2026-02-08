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
    return Scaffold(
        body: Obx(() => requestScreenController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Obx(() => requestScreenController.profiles.isEmpty &&
                    requestScreenController.specialProfiles.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 225,
                          child: Image.asset(
                            'assets/request_received.png',
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Primary Text
                        const Text(
                          "No new requests right now 👀",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Secondary Text
                        const Text(
                          "Keep engaging and you’ll start receiving requests. Someone special might be just around the corner!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : SingleUserRequest(
                    profiles: requestScreenController.profiles.value,
                    specialProfiles:
                        requestScreenController.specialProfiles.value))));
  }
}
