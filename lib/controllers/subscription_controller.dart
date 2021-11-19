// import 'dart:html';

import 'package:chat/controllers/authController.dart';
import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SubscriptionController extends GetxController {
  late Razorpay razorpay;
  final monthDiscountPr = ''.obs;
  final monthDiscountedPrice = ''.obs;
  final monthOriginalPrice = ''.obs;
  final weekDiscountPr = ''.obs;
  final weekDiscountedPrice = ''.obs;
  final weekOriginalPrice = ''.obs;
  final yearDiscountPr = ''.obs;
  final yearDiscountedPrice = ''.obs;
  final yearOriginalPrice = ''.obs;

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

  final oneWeekSelected = false.obs;
  final oneMonthSelected = false.obs;
  final oneYearSelected = false.obs;

  final oneBouquetSelected = false.obs;
  final fiveBouquetSelected = false.obs;
  final tenBouquetSelected = false.obs;

  final selectedBouqueMap = {}.obs;
  final selectedMessageMap = {}.obs;

  final bouqueUpload = {}.obs;
  final messageUpload = {}.obs;

  final currentItemMessage = true.obs;

  fetchPrices() async {
    isLoading.toggle();
    await FirebaseFirestore.instance
        .collection("Prices")
        .doc("Messaging")
        .get()
        .then((val) {
      Map<String, dynamic> messageMap = val.data()!;
      monthDiscountPr.value = messageMap["monthDiscountPr"].toString();
      monthDiscountedPrice.value =
          messageMap["monthDiscountedPrice"].toString();
      monthOriginalPrice.value = messageMap["monthOriginalPrice"].toString();
      weekDiscountPr.value = messageMap["weekDiscountPr"].toString();
      weekDiscountedPrice.value = messageMap["weekDiscountedPrice"].toString();
      weekOriginalPrice.value = messageMap["weekOriginalPrice"].toString();
      yearDiscountPr.value = messageMap["yearDiscountPr"].toString();
      yearDiscountedPrice.value = messageMap["yearDiscountedPrice"].toString();
      yearOriginalPrice.value = messageMap["yearOriginalPrice"].toString();
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

  void openCheckoutforMessage(Map<dynamic, dynamic> purchaseItem) {
    int amountToPay = int.parse(purchaseItem["messagePrice"]) * 100;
    var options = {
      "key": "rzp_test_il0OViv0cegj1c",
      "amount": "$amountToPay",
      "name": "Messaging",
      "description": purchaseItem["messageDuration"],
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
  }

  void openCheckoutforBouquets(Map<dynamic, dynamic> purchaseItem) {
    var options = {
      "key": "rzp_test_il0OViv0cegj1c",
      "amount": num.parse(purchaseItem["bookayPrice"]) * 100,
      "name": purchaseItem["bookayCount"],
      "description": "",
      "prefill": {
        "contact": "",
        "email": "",
      },
      "theme": {"color": "#FF5573"}
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Purchase Successfully!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromRGBO(255, 85, 115, 1),
        textColor: Color.fromRGBO(255, 255, 255, 1),
        fontSize: 16.0);

    if (currentItemMessage.value) {
      messageUpload['payment_id'] = response.paymentId;
      print('uploading in progress');
      oneWeekSelected.value = false;
      oneMonthSelected.value = false;
      oneYearSelected.value = false;
      isMessageSelected.value = false;

      DataBaseMethods().addMessaging(messageUpload.value);
    } else {
      bouqueUpload['payment_id'] = response.paymentId;
      oneBouquetSelected.value = false;
      fiveBouquetSelected.value = false;
      tenBouquetSelected.value = false;
      isBouqueSelected.value = false;
      DataBaseMethods().addBouquts(bouqueUpload.value);
    }
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
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
