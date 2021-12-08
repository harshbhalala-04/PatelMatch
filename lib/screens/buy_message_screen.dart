import 'package:chat/controllers/feed_screen_controller.dart';
import 'package:chat/controllers/subscription_controller.dart';
import 'package:chat/widgets/purchase_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BuyMessageScreen extends StatelessWidget {
  const BuyMessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? formattedDate;
    if (Get.find<FeedScreenController>().messageOpenTill.value != null) {
      DateTime reqDate = DateTime.fromMicrosecondsSinceEpoch(
          Get.find<FeedScreenController>()
              .messageOpenTill
              .value
              .microsecondsSinceEpoch);
      formattedDate = DateFormat("dd MMMM yyyy").format(reqDate);
      print(formattedDate);
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(() => InkWell(
                  onTap: () {
                    Get.find<SubscriptionController>().isMessageSelected.value =
                        true;

                    Get.find<SubscriptionController>().oneWeekSelected.value =
                        true;
                    Get.find<SubscriptionController>().oneMonthSelected.value =
                        false;
                    Get.find<SubscriptionController>().oneYearSelected.value =
                        false;
                    Get.find<SubscriptionController>()
                        .selectedMessageMap
                        .value = {
                      "messageDuration": "1 Week",
                      "messagePrice": Get.find<SubscriptionController>()
                          .weekDiscountedPrice
                          .value,
                    };

                    Timestamp messageOpenTill =
                        Get.find<FeedScreenController>().messageOpenTill.value;

                    if (messageOpenTill == null) {
                      messageOpenTill = Timestamp.now();
                    }
                    DateTime pastDate = messageOpenTill.toDate();

                    DateTime newDate = pastDate.add(Duration(days: 7));

                    Timestamp newTimestamp = Timestamp.fromDate(newDate);

                    Get.find<SubscriptionController>().messageUpload.value = {
                      "newTimestamp": newTimestamp,
                      "timestamp": DateTime.now(),
                      "timePeriod": "1 Week",
                      "messageCost": int.parse(
                          Get.find<SubscriptionController>()
                              .weekDiscountedPrice
                              .value),
                    };
                  },
                  child: Container(
                    decoration: Get.find<SubscriptionController>()
                            .oneWeekSelected
                            .value
                        ? BoxDecoration(
                            border: Border.all(
                              color: Color.fromRGBO(255, 85, 115, 1),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)))
                        : BoxDecoration(),
                    child: PurchaseCard(
                      isPopular: true,
                      currentPrice: Get.find<SubscriptionController>()
                          .weekDiscountedPrice
                          .value,
                      originalPrice: Get.find<SubscriptionController>()
                          .weekOriginalPrice
                          .value,
                      discountPr: Get.find<SubscriptionController>()
                          .weekDiscountPr
                          .value,
                      timePeriod: "1 Week",
                      fromBouquets: false,
                    ),
                  ),
                )),
            SizedBox(
              height: 15,
            ),
            Obx(() => InkWell(
                  onTap: () {
                    Get.find<SubscriptionController>().isMessageSelected.value =
                        true;
                    Get.find<SubscriptionController>().oneWeekSelected.value =
                        false;
                    Get.find<SubscriptionController>().oneMonthSelected.value =
                        true;
                    Get.find<SubscriptionController>().oneYearSelected.value =
                        false;
                    Get.find<SubscriptionController>()
                        .selectedMessageMap
                        .value = {
                      "messageDuration": "1 Month",
                      "messagePrice": Get.find<SubscriptionController>()
                          .monthDiscountedPrice
                          .value,
                    };
                    Timestamp messageOpenTill =
                        Get.find<FeedScreenController>().messageOpenTill.value;
                    if (messageOpenTill == null) {
                      messageOpenTill = Timestamp.now();
                    }
                    DateTime pastDate = messageOpenTill.toDate();

                    DateTime newDate = pastDate.add(Duration(days: 30));

                    Timestamp newTimestamp = Timestamp.fromDate(newDate);
                    Get.find<SubscriptionController>().messageUpload.value = {
                      "newTimestamp": newTimestamp,
                      "timestamp": Timestamp.now(),
                      "timePeriod": "1 Month",
                      "messageCost": int.parse(
                          Get.find<SubscriptionController>()
                              .monthDiscountedPrice
                              .value),
                    };
                  },
                  child: Container(
                    decoration: Get.find<SubscriptionController>()
                            .oneMonthSelected
                            .value
                        ? BoxDecoration(
                            border: Border.all(
                              color: Color.fromRGBO(255, 85, 115, 1),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)))
                        : BoxDecoration(),
                    child: PurchaseCard(
                      isPopular: false,
                      currentPrice: Get.find<SubscriptionController>()
                          .monthDiscountedPrice
                          .value,
                      originalPrice: Get.find<SubscriptionController>()
                          .monthOriginalPrice
                          .value,
                      discountPr: Get.find<SubscriptionController>()
                          .monthDiscountPr
                          .value,
                      timePeriod: "1 Month",
                      fromBouquets: false,
                    ),
                  ),
                )),
            SizedBox(
              height: 15,
            ),
            Obx(() => InkWell(
                  onTap: () {
                    Get.find<SubscriptionController>().isMessageSelected.value =
                        true;
                    Get.find<SubscriptionController>().oneWeekSelected.value =
                        false;
                    Get.find<SubscriptionController>().oneMonthSelected.value =
                        false;
                    Get.find<SubscriptionController>().oneYearSelected.value =
                        true;

                    Get.find<SubscriptionController>()
                        .selectedMessageMap
                        .value = {
                      "messageDuration": "1 Year",
                      "messagePrice": Get.find<SubscriptionController>()
                          .yearDiscountedPrice
                          .value,
                    };
                    Timestamp messageOpenTill =
                        Get.find<FeedScreenController>().messageOpenTill.value;
                    if (messageOpenTill == null) {
                      messageOpenTill = Timestamp.now();
                    }
                    DateTime pastDate = messageOpenTill.toDate();

                    DateTime newDate = pastDate.add(Duration(days: 365));

                    Timestamp newTimestamp = Timestamp.fromDate(newDate);
                    Get.find<SubscriptionController>().messageUpload.value = {
                      "newTimestamp": newTimestamp,
                      "timestamp": Timestamp.now(),
                      "timePeriod": "1 Year",
                      "messageCost": int.parse(
                          Get.find<SubscriptionController>()
                              .yearDiscountedPrice
                              .value),
                    };
                  },
                  child: Container(
                    decoration: Get.find<SubscriptionController>()
                            .oneYearSelected
                            .value
                        ? BoxDecoration(
                            border: Border.all(
                              color: Color.fromRGBO(255, 85, 115, 1),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)))
                        : BoxDecoration(),
                    child: PurchaseCard(
                      isPopular: false,
                      currentPrice: Get.find<SubscriptionController>()
                          .yearDiscountedPrice
                          .value,
                      originalPrice: Get.find<SubscriptionController>()
                          .yearOriginalPrice
                          .value,
                      discountPr: Get.find<SubscriptionController>()
                          .yearDiscountPr
                          .value,
                      timePeriod: "1 Year",
                      fromBouquets: false,
                    ),
                  ),
                )),
            SizedBox(
              height: 150,
            ),
            Get.find<FeedScreenController>().messageOpenTill.value == null
                ? SizedBox(
                    height: 50,
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    child: Card(
                      color: Color.fromRGBO(255, 85, 115, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Current plan expires on',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                color: Colors.white),
                          ),
                          Text(
                           formattedDate!,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
            SizedBox(
              height: 10,
            ),
            Get.find<FeedScreenController>().messageOpenTill.value == null
                ? SizedBox(
                    height: 10,
                  )
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text.rich(TextSpan(children: [
              TextSpan(
                    text: '*',
                    style: TextStyle(color: Color.fromRGBO(255, 185, 115, 1))),
              TextSpan(
                    text:
                        ' Any plans purchased during an active plan will get added onto'),
            ])),
                ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Obx(() => ElevatedButton(
                      onPressed: Get.find<SubscriptionController>()
                              .isMessageSelected
                              .value
                          ? () {
                              Get.find<SubscriptionController>()
                                  .currentItemMessage
                                  .value = true;
                              Get.find<SubscriptionController>()
                                  .openCheckoutforMessage(
                                Get.find<SubscriptionController>()
                                    .selectedMessageMap
                                    .value,
                              );
                            }
                          : () {},
                      child: Text(
                        'Make Payment',
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Get.find<SubscriptionController>()
                                  .isMessageSelected
                                  .value
                              ? Color.fromRGBO(255, 85, 115, 0.89)
                              : Color.fromRGBO(255, 85, 115, 0.5),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)))),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
