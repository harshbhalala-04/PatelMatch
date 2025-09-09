import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/screens/filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterWeightScreen extends StatefulWidget {
  const FilterWeightScreen({Key? key}) : super(key: key);

  @override
  _FilterWeightScreenState createState() => _FilterWeightScreenState();
}

class _FilterWeightScreenState extends State<FilterWeightScreen> {
  static double _lowerValue = 40;
  static double _upperValue = 130;
  RangeValues values = RangeValues(_lowerValue, _upperValue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Weight',
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
              'Weight',
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
              divisions: 90,
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
              List<int> weight = [];
              weight.add(values.start.toInt());
              weight.add(values.end.toInt());
              Get.find<GlobalController>().currentAppuser.value.filters!.weight =
                  weight;
              DataBaseMethods()
                  .filterWeight(values.start.toInt(), values.end.toInt());
              Get.off(FilterScreen());
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
}
