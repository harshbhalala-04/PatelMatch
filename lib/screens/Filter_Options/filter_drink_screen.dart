import 'package:chat/controllers/filter_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/helper/filterpinModel.dart';
import 'package:chat/screens/filter_screen.dart';
import 'package:chat/widgets/filter_pin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterDrinkScreen extends StatefulWidget {
  final String title;
  FilterDrinkScreen({required this.title});

  @override
  _FilterDrinkScreenState createState() => _FilterDrinkScreenState();
}

class _FilterDrinkScreenState extends State<FilterDrinkScreen> {
  final pins = [
    FilterPinModel(
        title: 'Never',
        value: Get.find<FilterController>().filterDrinkList.contains('Never')),
    FilterPinModel(
        title: 'Socially',
        value:
            Get.find<FilterController>().filterDrinkList.contains('Socially')),
    FilterPinModel(
        title: 'Regularly',
        value:
            Get.find<FilterController>().filterDrinkList.contains('Regularly')),
    FilterPinModel(
        title: 'Planning to quit',
        value: Get.find<FilterController>()
            .filterDrinkList
            .contains('Planning to quit')),
  ];
  final anyPin = FilterPinModel(title: 'Any',value: Get.find<FilterController>().filterDrinkList.contains('Any'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Drinking',
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
              DataBaseMethods().filterDrink(
                  Get.find<FilterController>().filterDrinkList.value);
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
            SizedBox(
              height: 15,
            ),
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
                  Get.find<FilterController>().filterDrinkList.add(pin.title);
                  Get.find<FilterController>().drinkSubtitle.value = 'Any';
                } else {
                  Get.find<FilterController>()
                      .filterDrinkList
                      .remove(pin.title);
                  Get.find<FilterController>().drinkSubtitle.value = ' ';
                }
              });
              if (isSelected) {
                Get.find<FilterController>().filterDrinkList.add(anyPin.title);
              } else {
                Get.find<FilterController>()
                    .filterDrinkList
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
                Get.find<FilterController>().filterDrinkList.add(pin.title);
              } else {
                Get.find<FilterController>().filterDrinkList.remove(pin.title);
              }

              String subtitle =
                  Get.find<FilterController>().drinkSubtitle.value;
              for (int i = 0;
                  i < Get.find<FilterController>().filterDrinkList.length;
                  i++) {
                if (i == 0) {
                  subtitle =
                      Get.find<FilterController>().filterDrinkList.elementAt(i);
                } else {
                  subtitle = subtitle +
                      ',' +
                      Get.find<FilterController>().filterDrinkList.elementAt(i);
                }
              }
              Get.find<FilterController>().drinkSubtitle.value = subtitle;
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
