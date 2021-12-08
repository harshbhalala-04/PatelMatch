import 'package:chat/controllers/global_controller.dart';
import 'package:chat/controllers/subscription_controller.dart';
import 'package:chat/widgets/purchase_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyBookayScreen extends StatelessWidget {
  const BuyBookayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(() => InkWell(
                  onTap: () {
                    Get.find<SubscriptionController>().isBouqueSelected.value =
                        true;
                    Get.find<SubscriptionController>()
                        .oneBouquetSelected
                        .value = true;
                    Get.find<SubscriptionController>()
                        .fiveBouquetSelected
                        .value = false;
                    Get.find<SubscriptionController>()
                        .tenBouquetSelected
                        .value = false;
                    Get.find<SubscriptionController>().selectedBouqueMap.value =
                        {"bookayCount": 1,
                          "bookayPrice": Get.find<SubscriptionController>().oneBouqueDiscountedPrice.value,
                        };
                    Get.find<SubscriptionController>().bouqueUpload.value = {
                      "timestamp": Timestamp.now(),
                      "bookayCount": 1,
                      "bookayCost": int.parse(Get.find<SubscriptionController>().oneBouqueDiscountedPrice.value),
                    };
                  },
                  child: Container(
                    decoration: Get.find<SubscriptionController>()
                            .oneBouquetSelected
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
                          .oneBouqueDiscountedPrice
                          .value,
                      originalPrice: Get.find<SubscriptionController>()
                          .oneBouqueOriginalPrice
                          .value,
                      discountPr: Get.find<SubscriptionController>()
                          .oneBouqueDiscountPr
                          .value,
                      timePeriod: "1",
                      fromBouquets: true,
                    ),
                  ),
                )),
            SizedBox(
              height: 15,
            ),
            Obx(() => InkWell(
                  onTap: () {
                    Get.find<SubscriptionController>().isBouqueSelected.value =
                        true;
                    Get.find<SubscriptionController>()
                        .oneBouquetSelected
                        .value = false;
                    Get.find<SubscriptionController>()
                        .fiveBouquetSelected
                        .value = true;
                    Get.find<SubscriptionController>()
                        .tenBouquetSelected
                        .value = false;
                     Get.find<SubscriptionController>().selectedBouqueMap.value =
                        {"bookayCount": 5,
                          "bookayPrice": Get.find<SubscriptionController>().fiveBouqueDiscountedPrice.value,
                        };
                    Get.find<SubscriptionController>().bouqueUpload.value = {
                      "timestamp": Timestamp.now(),
                      "bookayCount": 5,
                      "bookayCost": int.parse(Get.find<SubscriptionController>().fiveBouqueDiscountedPrice.value),
                    };
                  },
                  child: Container(
                    decoration: Get.find<SubscriptionController>()
                            .fiveBouquetSelected
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
                            .fiveBouqueDiscountedPrice
                            .value,
                        originalPrice: Get.find<SubscriptionController>()
                            .fiveBouqueOriginalPrice
                            .value,
                        discountPr: Get.find<SubscriptionController>()
                            .fiveBouqueDiscountPr
                            .value,
                        timePeriod: "5",
                        fromBouquets: true),
                  ),
                )),
            SizedBox(
              height: 15,
            ),
            Obx(() => InkWell(
                  onTap: () {
                    Get.find<SubscriptionController>().isBouqueSelected.value =
                        true;
                    Get.find<SubscriptionController>()
                        .oneBouquetSelected
                        .value = false;
                    Get.find<SubscriptionController>()
                        .fiveBouquetSelected
                        .value = false;
                    Get.find<SubscriptionController>()
                        .tenBouquetSelected
                        .value = true;
                     Get.find<SubscriptionController>().selectedBouqueMap.value =
                        {"bookayCount": 10,
                          "bookayPrice": Get.find<SubscriptionController>().tenBouqueDiscountedPrice.value,
                        };
                    Get.find<SubscriptionController>().bouqueUpload.value = {
                      "timestamp": Timestamp.now(),
                      "bookayCount": 10,
                      "bookayCost": int.parse(Get.find<SubscriptionController>().tenBouqueDiscountedPrice.value),
                    };
                  },
                  child: Container(
                    decoration: Get.find<SubscriptionController>()
                            .tenBouquetSelected
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
                          .tenBouqueDiscountedPrice
                          .value,
                      originalPrice: Get.find<SubscriptionController>()
                          .tenBouqueOriginalPrice
                          .value,
                      discountPr: Get.find<SubscriptionController>()
                          .tenBouqueDiscountPr
                          .value,
                      timePeriod: "10",
                      fromBouquets: true,
                    ),
                  ),
                )),
            SizedBox(
              height: 150,
            ),
            Container(
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
                      'My bouquets',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    ),
                    Text(
                      Get.find<GlobalController>().currentAppuser.value.bookayAvailable.toString(),
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
              height: 20,
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
                              .isBouqueSelected
                              .value
                          ? () {
                            Get.find<SubscriptionController>()
                                  .currentItemMessage
                                  .value = false;
                              Get.find<SubscriptionController>().openCheckoutforBouquets(Get.find<SubscriptionController>().selectedBouqueMap.value,);
                            }
                          : () {},
                      child: Text(
                        'Make Payment',
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Get.find<SubscriptionController>()
                                  .isBouqueSelected
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
