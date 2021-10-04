import 'package:chat/controllers/sent_screen_controller.dart';
import 'package:chat/screens/single_user_sent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

class SentScreen extends StatelessWidget {
  final sentScreenController = Get.put(SentScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sentScreenController.isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleUserSent(
              sentProfiles: sentScreenController.sentProfiles,
            ),
    );
  }
}
