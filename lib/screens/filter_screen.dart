import 'dart:ui';

import 'package:chat/controllers/filter_controller.dart';
import 'package:chat/controllers/global_controller.dart';
import 'package:chat/screens/Filter_Options/filter_age_screen.dart';
import 'package:chat/screens/Filter_Options/filter_drink_screen.dart';
import 'package:chat/screens/Filter_Options/filter_height_screen.dart';
import 'package:chat/screens/Filter_Options/filter_income_screen.dart';
import 'package:chat/screens/Filter_Options/filter_star_screen.dart';
import 'package:chat/screens/Filter_Options/filter_verified_screen.dart';
import 'package:chat/screens/Filter_Options/filter_weight_screen.dart';
import 'package:chat/screens/custom_tab_bar.dart';
import 'package:chat/widgets/filter_screen_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Filter_Options/filter_NRI_screen.dart';
import 'Filter_Options/filter_rashi_screen.dart';
import 'Filter_Options/filter_samaj_screen.dart';
import 'Filter_Options/filter_smoke_screen.dart';

class FilterScreen extends StatelessWidget {
  final filterController = Get.put(FilterController());
  @override
  Widget build(BuildContext context) {
    print(Get.find<GlobalController>().currentAppuser);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Filter',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: Get.find<FilterController>().isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Obx(() => InkWell(
                              child: FilterScreenCard(
                                title: 'Age',
                                subtitle: Get.find<GlobalController>()
                                            .currentAppuser
                                            .value
                                            .filters
                                            ?.age
                                            ?.length ==
                                        0
                                    ? ' '
                                    : '${Get.find<GlobalController>().currentAppuser.value.filters?.age?[0]} - ${Get.find<GlobalController>().currentAppuser.value.filters?.age?[1]}',
                              ),
                              onTap: () {
                                // Get.off(FilterAgeScreen());
                              },
                            )),
                        InkWell(
                          child: FilterScreenCard(
                            title: 'Weight',
                            subtitle: Get.find<GlobalController>()
                                        .currentAppuser
                                        .value
                                        .filters
                                        ?.weight
                                        ?.length ==
                                    0
                                ? ' '
                                : '${Get.find<GlobalController>().currentAppuser.value.filters?.weight?[0]} - ${Get.find<GlobalController>().currentAppuser.value.filters?.weight?[1]}',
                          ),
                          onTap: () {
                            // Get.off(FilterWeightScreen());
                          },
                        ),
                        InkWell(
                          child: FilterScreenCard(
                            title: 'Height',
                            subtitle: Get.find<GlobalController>()
                                        .currentAppuser
                                        .value
                                        .filters
                                        ?.height
                                        ?.length ==
                                    0
                                ? ' '
                                : '${Get.find<GlobalController>().currentAppuser.value.filters?.height?[0]} - ${Get.find<GlobalController>().currentAppuser.value.filters?.height?[1]}',
                          ),
                          onTap: () {
                            // Get.off(FilterHeightScreen());
                          },
                        ),
                        InkWell(
                          child: FilterScreenCard(
                            title: 'Income Range',
                            subtitle: Get.find<FilterController>()
                                .incomeSubtitle
                                .value,
                          ),
                          onTap: () {
                            // Get.off(FilterIncomeScreen());
                          },
                        ),
                        InkWell(
                          child: FilterScreenCard(
                            title: 'Samaj',
                            subtitle: Get.find<FilterController>()
                                .samajSubtitle
                                .value,
                          ),
                          onTap: () {
                            // Get.off(FilterSamajScreen());
                          },
                        ),
                        InkWell(
                          child: FilterScreenCard(
                              title: 'Verified Only',
                              subtitle: Get.find<FilterController>()
                                  .verifiedSubtitle
                                  .value),
                          onTap: () {
                            // Get.off(FilterVerifiedScreen());
                          },
                        ),
                        InkWell(
                          child: FilterScreenCard(
                              title: 'Star Sign',
                              subtitle: Get.find<FilterController>()
                                  .starSubtitle
                                  .value),
                          onTap: () {
                            // Get.off(FilterStarScreen());
                          },
                        ),
                        InkWell(
                          child: FilterScreenCard(
                              title: 'Rashi',
                              subtitle: Get.find<FilterController>()
                                  .rashiSubtitle
                                  .value),
                          onTap: () {
                            // Get.off(FilterRashiScreen());
                          },
                        ),
                        InkWell(
                          child: FilterScreenCard(
                              title: 'NRI',
                              subtitle: Get.find<FilterController>()
                                  .nriSubtitle
                                  .value),
                          onTap: () {
                            // Get.off(FilterNRIScreen());
                          },
                        ),
                        InkWell(
                          child: FilterScreenCard(
                              title: 'Do they drink?',
                              subtitle: Get.find<FilterController>()
                                  .drinkSubtitle
                                  .value),
                          onTap: () {
                            // Get.off(FilterDrinkScreen(title: 'Drinking'));
                          },
                        ),
                        InkWell(
                          child: FilterScreenCard(
                              title: 'Do they smoke?',
                              subtitle: Get.find<FilterController>()
                                  .smokeSubtitle
                                  .value),
                          onTap: () {
                            // Get.off(FilterSmokeScreen());
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: 325,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: ElevatedButton(
                              onPressed: () {
                                // Get.off(CustomTabBar());
                              },
                              child: Text(
                                'Done',
                                style: TextStyle(fontSize: 20),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(255, 85, 115, 0.89),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25)))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                    child: Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 6,
                      sigmaY: 6,
                    ),
                    child: Container(
                      height: 200,
                      child: AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        content: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Filter will be available soon",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  'Back to feed',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO(255, 85, 115, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ))
              ],
            ),
    );
  }
}
