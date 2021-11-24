import 'package:chat/controllers/global_controller.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_share/flutter_share.dart';

String mapKey = "AIzaSyCdAPr6-esjh1IezW2Bs5iqRXWTKT-Vrew";

List<DropdownMenuItem<String>> heights = [
    DropdownMenuItem(
      value: "4'0\"",
      child: Text("4'0\""),
    ),
    DropdownMenuItem(
      value: "4'1\"",
      child: Text("4'1\""),
    ),
    DropdownMenuItem(
      value: "4'2\"",
      child: Text("4'2\""),
    ),
    DropdownMenuItem(
      value:"4'3\"",
      child: Text("4'3\""),
    ),
    DropdownMenuItem(
      value: "4'4\"",
      child: Text("4'4\""),
    ),
    DropdownMenuItem(
      value: "4'5\"",
      child: Text("4'5\""),
    ),
    DropdownMenuItem(
      value: "4'6\"",
      child: Text("4'6\""),
    ),
    DropdownMenuItem(
      value: "4'7\"",
      child: Text("4'7\""),
    ),
    DropdownMenuItem(
      value: "4'8\"",
      child: Text("4'8\""),
    ),
    DropdownMenuItem(
      value: "4'9\"",
      child: Text("4'9\""),
    ),
    DropdownMenuItem(
      value: "4'10\"",
      child: Text("4'10\""),
    ),
    DropdownMenuItem(
      value: "4'11\"",
      child: Text("4'11\""),
    ),
    DropdownMenuItem(
      value: "5'0\"",
      child: Text("5'0\""),
    ),
    DropdownMenuItem(
      value: "5'1\"",
      child: Text("4'1\""),
    ),
    DropdownMenuItem(
      value: "5'2\"",
      child: Text("5'2\""),
    ),
    DropdownMenuItem(
      value: "5'3\"",
      child: Text("5'3\""),
    ),
    DropdownMenuItem(
      value: "5'4\"",
      child: Text("5'4\""),
    ),
    DropdownMenuItem(
      value: "5'5\"",
      child: Text("5'5\""),
    ),
    DropdownMenuItem(
      value: "5'6\"",
      child: Text("5'6\""),
    ),
    DropdownMenuItem(
      value: "5'7\"",
      child: Text("5'7\""),
    ),
    DropdownMenuItem(
      value:"5'8\"",
      child: Text("5'8\""),
    ),
    DropdownMenuItem(
      value: "5'9\"",
      child: Text("5'9\""),
    ),
    DropdownMenuItem(
      value: "5'10\"",
      child: Text("5'10\""),
    ),
    DropdownMenuItem(
      value: "5'11\"",
      child: Text("5'11\""),
    ),
    DropdownMenuItem(
      value: "6'0\"",
      child: Text("6'0\""),
    ),
    DropdownMenuItem(
      value: "6'1\"",
      child: Text("6'1\""),
    ),
    DropdownMenuItem(
      value: "6'2\"",
      child: Text("6'2\""),
    ),
    DropdownMenuItem(
      value: "6'3\"",
      child: Text("6'3\""),
    ),
    DropdownMenuItem(
      value: "6'4\"",
      child: Text("6'4\""),
    ),
    DropdownMenuItem(
      value: "6'5\"",
      child: Text("6'5\""),
    ),
    DropdownMenuItem(
      value: "6'6\"",
      child: Text("6'6\""),
    ),
    DropdownMenuItem(
      value: "6'7\"",
      child: Text("6'7\""),
    ),
    DropdownMenuItem(
      value:  "6'8\"",
      child: Text( "6'8\"",),
    ),
    DropdownMenuItem(
      value:  "6'9\"",
      child: Text( "6'9\"",),
    ),
    DropdownMenuItem(
      value:  "6'10\"",
      child: Text( "6'10\"",),
    ),
    DropdownMenuItem(
      value:  "6'11\"",
      child: Text( "6'11\"",),
    ),
    DropdownMenuItem(
      value: "7'0\"",
      child: Text( "7'0\"",),
    ),
    
  ];

String userId = Get.find<GlobalController>().currentAppuser.value.uid!;
String userName = Get.find<GlobalController>().currentAppuser.value.username!;
String imageUrl = Get.find<GlobalController>().currentAppuser.value.imgUrl!;

Future<void> createDynamicLink() async {
  Uri imageUri = Uri.parse(imageUrl);

  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: "https://patelmatch.page.link",
    link: Uri.parse("https://patelmatch.page.link/$userId"),
    androidParameters:
        AndroidParameters(packageName: "com.example.chat", minimumVersion: 0),
    socialMetaTagParameters: SocialMetaTagParameters(
      title: userName,
      imageUrl: imageUri,
    ),
  );

  final ShortDynamicLink shortLink = await parameters.buildShortLink();
  print(shortLink.toString());
  Uri url = shortLink.shortUrl;
  print(url.toString());
   await FlutterShare.share(
    title: 'Patel Match',
    linkUrl: url.toString(),
    text: userName,
    chooserTitle: 'Where You Want to Share',
  );
}


