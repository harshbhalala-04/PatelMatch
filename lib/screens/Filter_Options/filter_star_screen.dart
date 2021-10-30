import 'package:chat/controllers/filter_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/helper/filterpinModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../filter_screen.dart';

class FilterStarScreen extends StatefulWidget {
  const FilterStarScreen({Key? key}) : super(key: key);

  @override
  _FilterStarScreenState createState() => _FilterStarScreenState();
}

class _FilterStarScreenState extends State<FilterStarScreen> {

  final pins = [
    FilterPinModel(title: 'Ashwini', value: Get.find<FilterController>().filterStarList.contains('Ashwini')),
    FilterPinModel(title: 'Bharani', value: Get.find<FilterController>().filterStarList.contains('Bharani')),
    FilterPinModel(title: 'Krittika', value: Get.find<FilterController>().filterStarList.contains('Krittika')),
    FilterPinModel(title: 'Rohini', value: Get.find<FilterController>().filterStarList.contains('Rohini')),
    FilterPinModel(title: 'Mrigashirsha', value: Get.find<FilterController>().filterStarList.contains('Mrigashirsha')),
    FilterPinModel(title: 'Ardra', value: Get.find<FilterController>().filterStarList.contains('Ardra')),
    FilterPinModel(title: 'Punarvasu', value: Get.find<FilterController>().filterStarList.contains('Punarvasu')),
    FilterPinModel(title: 'Pushya', value: Get.find<FilterController>().filterStarList.contains('Pushya')),
    FilterPinModel(title: 'Ashlesha', value: Get.find<FilterController>().filterStarList.contains('Ashlesha')),
    FilterPinModel(title: 'Megha', value: Get.find<FilterController>().filterStarList.contains('Megha')),
    FilterPinModel(title: 'Hasta', value: Get.find<FilterController>().filterStarList.contains('Hasta')),
    FilterPinModel(title: 'Chitra', value: Get.find<FilterController>().filterStarList.contains('Chitra')),
    FilterPinModel(title: 'Svati', value: Get.find<FilterController>().filterStarList.contains('Svati')),
    FilterPinModel(title: 'Visakha', value: Get.find<FilterController>().filterStarList.contains('Visakha')),
    FilterPinModel(title: 'Anuradha',value: Get.find<FilterController>().filterStarList.contains('Anuradha')),
    FilterPinModel(title: 'Jyeshtha', value: Get.find<FilterController>().filterStarList.contains('Jyeshtha')),
    FilterPinModel(title: 'Mula', value: Get.find<FilterController>().filterStarList.contains('Mula')),
    FilterPinModel(title: 'Revati',value: Get.find<FilterController>().filterStarList.contains('Revati')),
    FilterPinModel(title: 'Sravaṇa', value: Get.find<FilterController>().filterStarList.contains('Sravaṇa')),
    FilterPinModel(title: 'Sravistha',value: Get.find<FilterController>().filterStarList.contains('Sravistha')),
    FilterPinModel(title: 'Shatabhisha', value: Get.find<FilterController>().filterStarList.contains('Shatabhisha')),
    FilterPinModel(title: 'Purva Ashadha', value: Get.find<FilterController>().filterStarList.contains('Purva Ashadha')),
    FilterPinModel(title: 'Uttara Ashadha', value: Get.find<FilterController>().filterStarList.contains('Uttara Ashadha')),
    FilterPinModel(title: 'Purva Bhadrapada', value: Get.find<FilterController>().filterStarList.contains('Purva Bhadrapada')),
    FilterPinModel(title: 'Uttara Bhadrapada', value: Get.find<FilterController>().filterStarList.contains('Uttara Bhadrapada')),
    FilterPinModel(title: 'Purva or Purva Phalguni', value: Get.find<FilterController>().filterStarList.contains('Purva or Purva Phalguni')),
    FilterPinModel(title: 'Uttara or Uttara Phalguni', value: Get.find<FilterController>().filterStarList.contains('Uttara or Uttara Phalguni')),
  ];

  final anyPin = FilterPinModel(title: 'Any', value: Get.find<FilterController>().filterStarList.contains('Any'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Star',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Get.back()),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: 325,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: ElevatedButton(
            onPressed: () {
              Get.off(FilterScreen());
              DataBaseMethods()
                  .filterStar(Get.find<FilterController>().filterStarList.value);
            },
            child: Text(
              'Done',
              style: TextStyle(fontSize: 20),
            ),
            style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(255, 85, 115, 0.89),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)))),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Multiple options can be selected.',
                style:
                    TextStyle(color: Color.fromRGBO(51, 51, 51, 1), fontSize: 18),
              ),
              SizedBox(height: 15,),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 3,
                    children: [
                      ...pins.map(filterChipWidget).toList(),
                      toggleChipWidget(anyPin),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget toggleChipWidget(FilterPinModel pin) => Container(
        child: FilterChip(
          backgroundColor: Colors.white,
          label: Text(pin.title),
          side: BorderSide(
              width: 5, color: Colors.grey.shade100, style: BorderStyle.solid),
          labelStyle: pin.value
              ? TextStyle(color: Colors.white, fontSize: 18)
              : TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
          disabledColor: Colors.white,
          showCheckmark: false,
          selected: pin.value,
          onSelected: (isSelected) {
            setState(() {
              anyPin.value = isSelected;
              pins.forEach((pin) {
                pin.value = isSelected;
                if (isSelected) {
                  Get.find<FilterController>().filterStarList.add(pin.title);
                  Get.find<FilterController>().starSubtitle.value = 'Any';
                } else {
                  Get.find<FilterController>()
                      .filterStarList
                      .remove(pin.title);
                  Get.find<FilterController>().starSubtitle.value = ' ';
                }
              });
               if (isSelected) {
                Get.find<FilterController>().filterStarList.add(anyPin.title);
              } else {
                Get.find<FilterController>()
                    .filterStarList
                    .remove(anyPin.title);
              }
            });
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          shadowColor: Color.fromRGBO(0, 0, 0, 0.15),
          selectedColor: Color.fromRGBO(255, 85, 115, 1),
          padding: EdgeInsets.only(left: 16, right: 16),
        ),
      );

  Widget filterChipWidget(FilterPinModel pin) => Container(
        child: FilterChip(
          backgroundColor: Colors.white,
          label: Text(pin.title),
          side: BorderSide(
              width: 5, color: Colors.grey.shade100, style: BorderStyle.solid),
          labelStyle: pin.value
              ? TextStyle(color: Colors.white, fontSize: 18)
              : TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
          disabledColor: Colors.white,
          showCheckmark: false,
          selected: pin.value,
          onSelected: (isSelected) {
            setState(() {
              pin.value = isSelected;
              if (isSelected) {
                Get.find<FilterController>().filterStarList.add(pin.title);
              } else {
                Get.find<FilterController>().filterStarList.remove(pin.title);
              }
              
              String subtitle =
                  Get.find<FilterController>().starSubtitle.value;
              for (int i = 0;
                  i < Get.find<FilterController>().filterStarList.length;
                  i++) {
                if (i == 0) {
                  subtitle =
                      Get.find<FilterController>().filterStarList.elementAt(i);
                } else {
                  subtitle = subtitle +
                      ',' +
                      Get.find<FilterController>().filterStarList.elementAt(i);
                }
              }
              Get.find<FilterController>().starSubtitle.value = subtitle;
            });
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          shadowColor: Color.fromRGBO(0, 0, 0, 0.15),
          selectedColor: Color.fromRGBO(255, 85, 115, 1),
          padding: EdgeInsets.only(left: 16, right: 16),
        ),
      );
}
