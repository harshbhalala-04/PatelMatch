import 'package:chat/controllers/subscription_controller.dart';
import 'package:chat/widgets/purchase_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyMessageScreen extends StatelessWidget {
  const BuyMessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    Get.find<SubscriptionController>().messageUpload.value = {
                      "timestamp": Timestamp.now(),
                      "timePeriod": "1 Week",
                      "messageCost": int.parse(
                          Get.find<SubscriptionController>()
                              .monthDiscountedPrice
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
                    Get.find<SubscriptionController>().messageUpload.value = {
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
                    Get.find<SubscriptionController>().messageUpload.value = {
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
              height: 250,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: 325,
                height: 40,
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
                              : Color.fromRGBO(255, 85, 115, 0.4),
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
