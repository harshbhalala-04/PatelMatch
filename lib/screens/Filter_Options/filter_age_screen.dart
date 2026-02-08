import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/screens/filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterAgeScreen extends StatefulWidget {
  @override
  _FilterAgeScreenState createState() => _FilterAgeScreenState();
}

class _FilterAgeScreenState extends State<FilterAgeScreen> {
  static double _lowerValue = 18;
  static double _upperValue = 70;

  RangeValues values = RangeValues(_lowerValue, _upperValue);

    
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Age',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Get.back()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Age',
              style: TextStyle(fontSize: 18),
            ),
            RangeSlider(
              activeColor: Color.fromRGBO(255, 85, 115, 1),
              inactiveColor: Color.fromRGBO(255, 204, 213, 1),
              labels: RangeLabels(
                values.start.toInt().toString(),
                values.end.toInt().toString(),
              ),
              min: _lowerValue,
              max: _upperValue,
              divisions: 52,
              values: values,
              onChanged: (val) {
                print(val);
                setState(() {
                  values = val;
                });
              },
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
              List<int> age = [];
              age.add(values.start.toInt());
              age.add(values.end.toInt());
              Get.find<GlobalController>().currentAppuser.value.filters!.age =
                  age;
              DataBaseMethods()
                  .filterAge(values.start.toInt(), values.end.toInt());
              Get.off(FilterScreen());
            },
            child: Text(
              'Done',
              style: TextStyle(fontSize: 20, color: Colors.white),
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
}
