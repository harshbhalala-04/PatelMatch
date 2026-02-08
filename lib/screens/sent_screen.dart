import 'package:chat/controllers/request_screen_controller.dart';
import 'package:chat/controllers/sent_screen_controller.dart';
import 'package:chat/screens/custom_tab_bar.dart';
import 'package:chat/screens/single_user_sent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SentScreen extends StatelessWidget {
  final sentScreenController = Get.put(SentScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sentScreenController.isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : sentScreenController.sentProfiles.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 225,
                        child: Image.asset(
                          'assets/request_sent.png',
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Primary Text
                      const Text(
                        "You haven’t sent any requests yet ✨",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Secondary Text
                      const Text(
                        "Start connecting with people you like. Send a request and break the ice!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              : SingleUserSent(
                  sentProfiles: sentScreenController.sentProfiles,
                ),
    );
  }
}
