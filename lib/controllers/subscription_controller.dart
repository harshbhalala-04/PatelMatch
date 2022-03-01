// import 'dart:html';

import 'dart:convert';
import 'dart:io';

import 'package:chat/controllers/authController.dart';
import 'package:chat/controllers/bookay_controller.dart';
import 'package:chat/controllers/feed_screen_controller.dart';
import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SubscriptionController extends GetxController {
  late Razorpay razorpay;

  final firstDurationDiscountPr = ''.obs;
  final firstDurationDiscountedPrice = ''.obs;
  final firstDurationName = ''.obs;
  final firstDurationOriginalPrice = ''.obs;
  final secondDurationDiscountPr = ''.obs;
  final secondDurationDiscountedPrice = ''.obs;
  final secondDurationOriginalPrice = ''.obs;
  final secondDurationName = ''.obs;
  final thirdDurationDiscountPr = ''.obs;
  final thirdDurationDiscountedPrice = ''.obs;
  final thirdDurationName = ''.obs;
  final thirdDurationOriginalPrice = ''.obs;

  final isFirstDurationPopular = false.obs;
  final isSecondDurationPopular = false.obs;
  final isThirdDurationPopular = false.obs;

  final fiveBouqueDiscountPr = ''.obs;
  final fiveBouqueDiscountedPrice = ''.obs;
  final fiveBouqueOriginalPrice = ''.obs;
  final oneBouqueDiscountPr = ''.obs;
  final oneBouqueDiscountedPrice = ''.obs;
  final oneBouqueOriginalPrice = ''.obs;
  final tenBouqueDiscountPr = ''.obs;
  final tenBouqueDiscountedPrice = ''.obs;
  final tenBouqueOriginalPrice = ''.obs;

  final isLoading = false.obs;
  final isBouqueSelected = false.obs;
  final isMessageSelected = false.obs;

  // final oneWeekSelected = false.obs;
  // final oneMonthSelected = false.obs;
  // final oneYearSelected = false.obs;

  final firstDurationSelected = false.obs;
  final secondDurationSelected = false.obs;
  final thirdDurationSelected = false.obs;

  final oneBouquetSelected = false.obs;
  final fiveBouquetSelected = false.obs;
  final tenBouquetSelected = false.obs;

  final selectedBouqueMap = {}.obs;
  final selectedMessageMap = {}.obs;

  final bouqueUpload = {}.obs;
  final messageUpload = {}.obs;

  final currentItemMessage = true.obs;

  final feedScreenController = Get.put(FeedScreenController());

  // Key Id = rzp_test_er32Zjib0yRHwa
  // Key secret = 2783Ko3b8msxz5JRNYP2mfsv

  fetchPrices() async {
    isLoading.toggle();
    await FirebaseFirestore.instance
        .collection("Prices")
        .doc("Messaging")
        .get()
        .then((val) {
      Map<String, dynamic> messageMap = val.data()!;

      firstDurationName.value = messageMap["firstDurationName"];
      secondDurationName.value = messageMap["secondDurationName"];
      thirdDurationName.value = messageMap["thirdDurationName"];

      isFirstDurationPopular.value = messageMap["isFirstDurationPopular"];
      isSecondDurationPopular.value = messageMap["isSecondDurationPopular"];
      isThirdDurationPopular.value = messageMap["isThirdDurationPopular"];

      firstDurationDiscountedPrice.value =
          messageMap["firstDurationDiscountedPrice"].toString();
      firstDurationOriginalPrice.value =
          messageMap["firstDurationOriginalPrice"].toString();
      firstDurationDiscountPr.value =
          messageMap["firstDurationDiscountPr"].toString();
      secondDurationDiscountedPrice.value =
          messageMap["secondDurationDiscountedPrice"].toString();
      secondDurationOriginalPrice.value =
          messageMap["secondDurationOriginalPrice"].toString();
      secondDurationDiscountPr.value =
          messageMap["secondDurationDiscountPr"].toString();
      thirdDurationDiscountPr.value =
          messageMap["thirdDurationDiscountPr"].toString();
      thirdDurationDiscountedPrice.value =
          messageMap["thirdDurationDiscountedPrice"].toString();
      thirdDurationOriginalPrice.value =
          messageMap["thirdDurationOriginalPrice"].toString();
    });

    await FirebaseFirestore.instance
        .collection("Prices")
        .doc("Bouquets")
        .get()
        .then((val) {
      Map<String, dynamic> bouquetMap = val.data()!;
      oneBouqueDiscountPr.value = bouquetMap["oneBouqueDiscountPr"].toString();
      oneBouqueDiscountedPrice.value =
          bouquetMap["oneBouqueDiscountedPrice"].toString();
      oneBouqueOriginalPrice.value =
          bouquetMap["oneBouqueOriginalPrice"].toString();
      fiveBouqueDiscountPr.value =
          bouquetMap["fiveBouqueDiscountPr"].toString();
      fiveBouqueDiscountedPrice.value =
          bouquetMap["fiveBouqueDiscountedPrice"].toString();
      fiveBouqueOriginalPrice.value =
          bouquetMap["fiveBouqueOriginalPrice"].toString();
      tenBouqueDiscountPr.value = bouquetMap["tenBouqueDiscountPr"].toString();
      tenBouqueDiscountedPrice.value =
          bouquetMap["tenBouqueDiscountedPrice"].toString();
      tenBouqueOriginalPrice.value =
          bouquetMap["tenBouqueOriginalPrice"].toString();
    });
    isLoading.toggle();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);

    fetchPrices();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    razorpay.clear();
    super.dispose();
  }

  openCheckoutforMessage(Map<dynamic, dynamic> purchaseItem) async {
    int amountToPay = int.parse(purchaseItem["messagePrice"]) * 100;
    final client = HttpClient();
    final request =
        await client.postUrl(Uri.parse('https://api.razorpay.com/v1/orders'));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    String basicAuth = 'Basic ' +
        base64Encode(
            utf8.encode('rzp_test_er32Zjib0yRHwa:2783Ko3b8msxz5JRNYP2mfsv'));
    // String basicAuth = 'Basic ' +
    //     base64Encode(
    //         utf8.encode('rzp_live_BsJlfNy4KTNyHA:JjPK73y2HZGnKGhJCGgfI7gM'));
    request.headers.set(HttpHeaders.authorizationHeader, basicAuth);
    request.add(utf8.encode(json.encode({
      "amount": amountToPay,
      "currency": "INR",
      'receipt': "order_rcptid_11"
    })));
    final response = await request.close();

    response.transform(utf8.decoder).listen((contents) {
      print('ORDERID' + contents);
      String orderId = contents.split(',')[0].split(":")[1];
      orderId = orderId.substring(1, orderId.length - 1);
      print("Here is the orderId: $orderId");
      // int amountToPay = 1 * 100;
      var options = {
        "key": "rzp_test_er32Zjib0yRHwa",
        "amount": amountToPay,
        "currency": "INR",
        "name": "Messaging",
        'order_id': orderId,
        // 'timeout': 60,
        "description": "",
        "prefill": {
          "contact": Get.find<GlobalController>().currentAppuser.value.phoneNo,
          "email": Get.find<GlobalController>().currentAppuser.value.email,
        },
        "external": {
          "wallets": ["paytm"]
        },
        "theme": {"color": "#FF5573"}
      };
      try {
        razorpay.open(options);
      } catch (e) {
        print(e.toString());
      }
    });
  }

  openCheckoutforBouquets(Map<dynamic, dynamic> purchaseItem) async {
    int amountToPay = int.parse(purchaseItem["bookayPrice"]) * 100;
    final client = HttpClient();
    final request =
        await client.postUrl(Uri.parse('https://api.razorpay.com/v1/orders'));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    String basicAuth = 'Basic ' +
        base64Encode(
            utf8.encode('rzp_test_er32Zjib0yRHwa:2783Ko3b8msxz5JRNYP2mfsv'));
    request.headers.set(HttpHeaders.authorizationHeader, basicAuth);
    request.add(utf8.encode(json.encode({
      "amount": amountToPay,
      "currency": "INR",
      'receipt': "order_rcptid_11"
    })));
    final response = await request.close();

    response.transform(utf8.decoder).listen((contents) {
      print('ORDERID' + contents);
      String orderId = contents.split(',')[0].split(":")[1];
      orderId = orderId.substring(1, orderId.length - 1);
      print("____________________________");
      print("Here orderId: $orderId");

      // int amountToPay = 1 * 100;
      var options = {
        "key": "rzp_test_er32Zjib0yRHwa",
        "amount": amountToPay,
        "name": purchaseItem["bookayCount"],
        "description": "",
        "currency": "INR",
        // 'timeout': 60,
        "order_id": orderId,
        "prefill": {
          "contact": Get.find<GlobalController>().currentAppuser.value.phoneNo,
          "email": Get.find<GlobalController>().currentAppuser.value.email,
        },
        "theme": {"color": "#FF5573"}
      };
      try {
        razorpay.open(options);
      } catch (e) {
        print(e.toString());
      }
    });
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Purchase Successfully!, pull to refresh the page",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromRGBO(255, 85, 115, 1),
        textColor: Color.fromRGBO(255, 255, 255, 1),
        fontSize: 16.0);

    print("___________________________");
    print("Here is the order id: ${response.orderId}");

    if (currentItemMessage.value) {
      messageUpload['payment_id'] = response.paymentId;
      print('uploading in progress');
      firstDurationSelected.value = false;
      secondDurationSelected.value = false;
      thirdDurationSelected.value = false;
      isMessageSelected.value = false;
      Get.find<FeedScreenController>().messageOpenTill.value =
          messageUpload['newTimestamp'];
      print(
          "New Time stamp: ${Get.find<FeedScreenController>().messageOpenTill}");
      DataBaseMethods().addMessaging(messageUpload.value);
    } else {
      final bookayController = Get.put(BookayController());
      bouqueUpload['payment_id'] = response.paymentId;
      oneBouquetSelected.value = false;
      fiveBouquetSelected.value = false;
      tenBouquetSelected.value = false;
      isBouqueSelected.value = false;
      int bookay = bouqueUpload['bookayCount'];
      int pastBookay =
          Get.find<GlobalController>().currentAppuser.value.bookayAvailable!;
      Get.find<GlobalController>().currentAppuser.value.bookayAvailable =
          bookay + pastBookay;
      Get.find<BookayController>().bookayCount.value = bookay + pastBookay;
      print(
          "New Bookay available are : ${Get.find<GlobalController>().currentAppuser.value.bookayAvailable}");

      DataBaseMethods().addBouquts(bouqueUpload.value);
    }
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    print("Here is payment failure response");
    print("_____________________________");
    print(response.code);
    print(response.message);

    Fluttertoast.showToast(
        msg: "ERROR: Payment Unsuccessful.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromRGBO(255, 85, 115, 1),
        textColor: Color.fromRGBO(255, 255, 255, 1),
        fontSize: 16.0);
  }

  void handlerExternalWallet(ExternalWalletResponse response) {}
}
