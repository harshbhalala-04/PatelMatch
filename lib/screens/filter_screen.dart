import 'package:chat/controllers/global_controller.dart';
import 'package:chat/screens/Filter_Options/filter_age_screen.dart';
import 'package:chat/screens/Filter_Options/filter_drink_screen.dart';
import 'package:chat/screens/Filter_Options/filter_height_screen.dart';
import 'package:chat/screens/Filter_Options/filter_income_screen.dart';
import 'package:chat/screens/Filter_Options/filter_star_screen.dart';
import 'package:chat/screens/Filter_Options/filter_verified_screen.dart';
import 'package:chat/screens/Filter_Options/filter_weight_screen.dart';
import 'package:chat/screens/Filter_Options/multiselect.dart';
import 'package:chat/screens/onboarding_screens/samaj_screen.dart';
import 'package:chat/widgets/filter_screen_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Filter_Options/filter_rashi_screen.dart';
import 'Filter_Options/filter_samaj_screen.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
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
                                  ?.age?[0] ==
                              null
                          ? ' '
                          : '${Get.find<GlobalController>().currentAppuser.value.filters?.age?[0]} - ${Get.find<GlobalController>().currentAppuser.value.filters?.age?[1]}',
                    ),
                    onTap: () {
                      Get.off(FilterAgeScreen());
                    },
                  )),
              InkWell(
                child: FilterScreenCard(
                  title: 'Weight',
                  subtitle: Get.find<GlobalController>()
                              .currentAppuser
                              .value
                              .filters
                              ?.weight?[0] ==
                          null
                      ? ' '
                      : '${Get.find<GlobalController>().currentAppuser.value.filters?.weight?[0]} - ${Get.find<GlobalController>().currentAppuser.value.filters?.weight?[1]}',
                ),
                onTap: () {
                  Get.off(FilterWeightScreen());
                },
              ),
              InkWell(
                child: FilterScreenCard(title: 'Height', subtitle: ''),
                onTap: () {
                  Get.off(FilterHeightScreen());
                },
              ),
            
              InkWell(
                child: FilterScreenCard(title: 'Income Range', subtitle: ''),
                onTap: () {
                  Get.off(FilterIncomeScreen());
                },
              ),
              InkWell(
                child: FilterScreenCard(title: 'Samaj', subtitle: ''),
                onTap: () {
                  Get.off(FilterSamajScreen());
                },
              ),
              InkWell(
                child: FilterScreenCard(title: 'Verified Only', subtitle: ''),
                onTap: () {
                  Get.off(FilterVerifiedScreen());
                },
              ),
              InkWell(
                child: FilterScreenCard(title: 'Star Sign', subtitle: ''),
                onTap: () {
                  // Get.off(FilterStarScreen());
                },
              ),
              InkWell(
                child: FilterScreenCard(title: 'Rashi', subtitle: ''),
                onTap: () {
                  // Get.off(FilterRashiScreen());
                },
              ),
              InkWell(
                child: FilterScreenCard(title: 'Do they drink?', subtitle: ''),
                onTap: () {
                  Get.off(FilterDrinkScreen(title: 'Drinking'));
                },
              ),
              InkWell(
                child: FilterScreenCard(title: 'Do they smoke?', subtitle: ''),
                onTap: () {
                  Get.off(FilterDrinkScreen(title: 'Smoking'));
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
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Done',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(255, 85, 115, 0.89),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25)))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
