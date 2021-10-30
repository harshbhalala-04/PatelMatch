import 'package:chat/controllers/filter_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/helper/filterpinModel.dart';
import 'package:chat/widgets/filter_pin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../filter_screen.dart';

class FilterVerifiedScreen extends StatefulWidget {
  const FilterVerifiedScreen({Key? key}) : super(key: key);

  @override
  _FilterVerifiedScreenState createState() => _FilterVerifiedScreenState();
}

class _FilterVerifiedScreenState extends State<FilterVerifiedScreen> {
  final pins = [
    FilterPinModel(title: 'Verified', value: Get.find<FilterController>().filterVerifiedList.contains('Verified')),
    FilterPinModel(title: 'Non Verified',  value: Get.find<FilterController>().filterVerifiedList.contains('Non Verified')),
    
  ];
  final anyPin = FilterPinModel(title: 'Any', value: Get.find<FilterController>().filterVerifiedList.contains('Any'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verified Profile',
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
                  .filterVerified(Get.find<FilterController>().filterVerifiedList.value);
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
      body:Padding(
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
                  Get.find<FilterController>().filterVerifiedList.add(pin.title);
                  Get.find<FilterController>().verifiedSubtitle.value = 'Any';
                } else {
                  Get.find<FilterController>()
                      .filterVerifiedList
                      .remove(pin.title);
                  Get.find<FilterController>().verifiedSubtitle.value = ' ';
                }
              });
               if (isSelected) {
                Get.find<FilterController>().filterVerifiedList.add(anyPin.title);
              } else {
                Get.find<FilterController>()
                    .filterVerifiedList
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
                Get.find<FilterController>().filterVerifiedList.add(pin.title);
              } else {
                Get.find<FilterController>().filterVerifiedList.remove(pin.title);
              }
              
              String subtitle =
                  Get.find<FilterController>().verifiedSubtitle.value;
              for (int i = 0;
                  i < Get.find<FilterController>().filterVerifiedList.length;
                  i++) {
                if (i == 0) {
                  subtitle =
                      Get.find<FilterController>().filterVerifiedList.elementAt(i);
                } else {
                  subtitle = subtitle +
                      ',' +
                      Get.find<FilterController>().filterVerifiedList.elementAt(i);
                }
              }
              Get.find<FilterController>().verifiedSubtitle.value = subtitle;
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