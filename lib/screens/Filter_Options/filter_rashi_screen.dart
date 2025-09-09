import 'package:chat/controllers/filter_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/helper/filterpinModel.dart';
import 'package:chat/widgets/filter_pin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../filter_screen.dart';

class FilterRashiScreen extends StatefulWidget {
  const FilterRashiScreen({Key? key}) : super(key: key);

  @override
  _FilterRashiScreenState createState() => _FilterRashiScreenState();
}

class _FilterRashiScreenState extends State<FilterRashiScreen> {
  final pins = [
    FilterPinModel(title: 'Aries', value: Get.find<FilterController>().filterRashiList.contains('Aries')),
    FilterPinModel(title: 'Taurus', value: Get.find<FilterController>().filterRashiList.contains('Taurus')),
    FilterPinModel(title: 'Gemini', value: Get.find<FilterController>().filterRashiList.contains('Gemini')),
    FilterPinModel(title: 'Cancer', value: Get.find<FilterController>().filterRashiList.contains('Cancer')),
    FilterPinModel(title: 'Leo', value: Get.find<FilterController>().filterRashiList.contains('Leo')),
    FilterPinModel(title: 'Virgo', value: Get.find<FilterController>().filterRashiList.contains('Virgo')),
    FilterPinModel(title: 'Libra', value: Get.find<FilterController>().filterRashiList.contains('Libra')),
    FilterPinModel(title: 'Scorpio', value: Get.find<FilterController>().filterRashiList.contains('Scorpio')),
    FilterPinModel(title: 'Capricorn', value: Get.find<FilterController>().filterRashiList.contains('Capricorn')),
    FilterPinModel(title: 'Aquarius', value: Get.find<FilterController>().filterRashiList.contains('Aquarius')),
    FilterPinModel(title: 'Pisces', value: Get.find<FilterController>().filterRashiList.contains('Pisces')),
    FilterPinModel(title: 'Saggitarius', value: Get.find<FilterController>().filterRashiList.contains('Saggitarius')),
  ];
  final anyPin = FilterPinModel(title: 'Any', value: Get.find<FilterController>().filterRashiList.contains('Any'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Rashi',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Get.back()),
        centerTitle: true,
      ),
      body: Padding(
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
                  .filterRashi(Get.find<FilterController>().filterRashiList.value);
            },
            child: Text(
              'Done',
              style: TextStyle(fontSize: 20),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(255, 85, 115, 0.89),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)))),
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
                  Get.find<FilterController>().filterRashiList.add(pin.title);
                  Get.find<FilterController>().rashiSubtitle.value = 'Any';
                } else {
                  Get.find<FilterController>()
                      .filterRashiList
                      .remove(pin.title);
                  Get.find<FilterController>().rashiSubtitle.value = ' ';
                }
              });
               if (isSelected) {
                Get.find<FilterController>().filterRashiList.add(anyPin.title);
              } else {
                Get.find<FilterController>()
                    .filterRashiList
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
                Get.find<FilterController>().filterRashiList.add(pin.title);
              } else {
                Get.find<FilterController>().filterRashiList.remove(pin.title);
              }
              
              String subtitle =
                  Get.find<FilterController>().rashiSubtitle.value;
              for (int i = 0;
                  i < Get.find<FilterController>().filterRashiList.length;
                  i++) {
                if (i == 0) {
                  subtitle =
                      Get.find<FilterController>().filterRashiList.elementAt(i);
                } else {
                  subtitle = subtitle +
                      ',' +
                      Get.find<FilterController>().filterRashiList.elementAt(i);
                }
              }
              Get.find<FilterController>().rashiSubtitle.value = subtitle;
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
