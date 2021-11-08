// Package imports:
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat/screens/chat_section/message_screen.dart';
import 'package:chat/screens/custom_tab_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';

dynamic createLocalNotification({required Map<String, dynamic> message}) async {
  final Map<String, String> data = {};

  message.forEach((key, value) {
    data[key] = value.toString();
  });

  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: int.parse(randomNumeric(3)),
          channelKey: 'basic_channel',
          title: message['title'],
          body: message['message'],
          payload: data));
}

/// Converting Remote Notifcation To Local Notification
handleNetworkNotification(RemoteMessage message) {
  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: int.parse(randomNumeric(3)),
          channelKey: 'basic_channel',
          title: message.notification!.title,
          body: message.notification!.body,
          payload: {}));
}

/// Will be called when the app is terminated
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await createLocalNotification(message: message.data);
}

dynamic initializeLocalNotification() {
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        importance: NotificationImportance.Max,
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Colors.black,
        channelShowBadge: true,
        ledColor: Colors.white)
  ]);
}

dynamic handleNotificationRouting(
    {required Map<String, dynamic> message}) async {
  switch (message['screen']) {
    case 'custom_tab_bar':
      Get.to(CustomTabBar());
      break;
    case 'message_screen':
      Get.to(MessageScreen());
      break;
    default:
    // case 'order':
    //   await databaseReference
    //       .collection('ORDERS')
    //       .doc(message['orderId'])
    //       .get()
    //       .then((snapshot) {
    //     if (snapshot.exists) {
    //       Get.to(OrderDetails(order: Order.fromJson(snapshot.data()!)));
    //     }
    //   });
    //   break;
    // case 'category':
    //   await databaseReference
    //       .collection('CATEGORIES')
    //       .doc(message['documentId'])
    //       .get()
    //       .then((snapshot) {
    //     if (snapshot.exists) {
    //       Get.to(ProductCategory(
    //           // isSubcategory: false,
    //           query: databaseReference
    //               .collection('PRODUCTS')
    //               .where('categories', arrayContainsAny: [
    //                 {
    //                   'id': snapshot.data()!['id'],
    //                   'name': snapshot.data()!['name'].toLowerCase()
    //                 }
    //               ])
    //               .where('isOutOfStock', isEqualTo: false)
    //               .orderBy('createdAt', descending: true),
    //           category: Category.fromJson(snapshot.data()!)));
    //     }
    //   });
    //   break;
    // case 'subCategory':
    //   await databaseReference
    //       .collection('SUBCATEGORIES')
    //       .doc(message['documentId'])
    //       .get()
    //       .then((snapshot) {
    //     if (snapshot.exists) {
    //       Get.to(ShopProductSubCategoryView(
    //           subCategory: SubCategory.fromJson(snapshot.data()!)));
    //     }
    //   });
    //   break;
    // case 'product':
    //   await databaseReference
    //       .collection('PRODUCTS')
    //       .doc(message['documentId'])
    //       .get()
    //       .then((snapshot) {
    //     if (snapshot.exists) {
    //       Get.to(ProductPage(product: Product.fromJson(snapshot.data()!)));
    //     }
    //   });
    //   break;
    // default:
  }
}
