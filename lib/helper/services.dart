// import 'dart:js';

import 'package:chat/controllers/global_controller.dart';
import 'package:get/get.dart';

String mapKey = "AIzaSyCdAPr6-esjh1IezW2Bs5iqRXWTKT-Vrew";

List<String> heights = [
  "4'0\"",
  "4'1\"",
  "4'2\"",
  "4'3\"",
  "4'4\"",
  "4'5\"",
  "4'6\"",
  "4'7\"",
  "4'8\"",
  "4'9\"",
  "4'10\"",
  "4'11\"",
  "5'0\"",
  "5'1\"",
  "5'2\"",
  "5'3\"",
  "5'4\"",
  "5'5\"",
  "5'6\"",
  "5'7\"",
  "5'8\"",
  "5'9\"",
  "5'10\"",
  "5'11\"",
  "6'0\"",
      "6'1\"",
  "6'2\"",
  "6'3\"",
  "6'4\"",
  "6'5\"",
  "6'6\"",
  "6'7\"",
  "6'8\"",
  "6'9\"",
  "6'10\"",
  "6'11\"",
  "7'0\"",
];

String userId = Get.find<GlobalController>().currentAppuser.value.uid!;
String userName = Get.find<GlobalController>().currentAppuser.value.username!;
String imageUrl = Get.find<GlobalController>().currentAppuser.value.imgUrl!;

Future<void> createDynamicLink() async {
  // Uri imageUri = Uri.parse(imageUrl);

  // final DynamicLinkParameters parameters = DynamicLinkParameters(
  //   uriPrefix: "https://patelmatch.page.link",
  //   link: Uri.parse("https://patelmatch.page.link/$userId"),
  //   androidParameters:
  //       AndroidParameters(packageName: "com.patelMatch.chat", minimumVersion: 0),
  //   socialMetaTagParameters: SocialMetaTagParameters(
  //     title: userName,
  //     imageUrl: imageUri,
  //   ),
  // );

  // final ShortDynamicLink shortLink = await parameters.buildShortLink();
  // print(shortLink.toString());
  // Uri url = shortLink.shortUrl;
  // print(url.toString());
  // await Share.share(url.toString(), subject: userName);
  //  await FlutterShare.share(
  //   title: 'Patel Match',
  //   linkUrl: url.toString(),
  //   text: userName,
  //   chooserTitle: 'Where You Want to Share',
  // );
}
