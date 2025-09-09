import 'package:chat/controllers/filter_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/helper/filterpinModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../filter_screen.dart';

class FilterSmokeScreen extends StatefulWidget {
  const FilterSmokeScreen({ Key? key }) : super(key: key);

  @override
  _FilterSmokeScreenState createState() => _FilterSmokeScreenState();
}

class _FilterSmokeScreenState extends State<FilterSmokeScreen> {
 final pins = [
    FilterPinModel(title: 'Never', value: Get.find<FilterController>().filterSmokeList.contains('Never')),
    FilterPinModel(title: 'Socially', value: Get.find<FilterController>().filterSmokeList.contains('Socially')),
    FilterPinModel(title: 'Regularly', value: Get.find<FilterController>().filterSmokeList.contains('Regularly')),
    FilterPinModel(title: 'Planning to quit', value: Get.find<FilterController>().filterSmokeList.contains('Planning to quit')),
    
  ];
  final anyPin = FilterPinModel(title: 'Any', value: Get.find<FilterController>().filterSmokeList.contains('Any'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Smoking',
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
                  .filterSmoke(Get.find<FilterController>().filterSmokeList.value);
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
                  Get.find<FilterController>().filterSmokeList.add(pin.title);
                  Get.find<FilterController>().smokeSubtitle.value = 'Any';
                } else {
                  Get.find<FilterController>()
                      .filterSmokeList
                      .remove(pin.title);
                  Get.find<FilterController>().smokeSubtitle.value = ' ';
                }
              });
               if (isSelected) {
                Get.find<FilterController>().filterSmokeList.add(anyPin.title);
              } else {
                Get.find<FilterController>()
                    .filterSmokeList
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
                Get.find<FilterController>().filterSmokeList.add(pin.title);
              } else {
                Get.find<FilterController>().filterSmokeList.remove(pin.title);
              }
              
              String subtitle =
                  Get.find<FilterController>().smokeSubtitle.value;
              for (int i = 0;
                  i < Get.find<FilterController>().filterSmokeList.length;
                  i++) {
                if (i == 0) {
                  subtitle =
                      Get.find<FilterController>().filterSmokeList.elementAt(i);
                } else {
                  subtitle = subtitle +
                      ',' +
                      Get.find<FilterController>().filterSmokeList.elementAt(i);
                }
              }
              Get.find<FilterController>().smokeSubtitle.value = subtitle;
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