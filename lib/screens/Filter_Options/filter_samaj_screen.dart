import 'package:chat/controllers/Filter_Controller/filter_rashi_controller.dart';
import 'package:chat/widgets/filter_pin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../filter_screen.dart';

class FilterSamajScreen extends StatefulWidget {
  const FilterSamajScreen({Key? key}) : super(key: key);

  @override
  _FilterSamajScreenState createState() => _FilterSamajScreenState();
}

class _FilterSamajScreenState extends State<FilterSamajScreen> {
  final filterController = Get.put(FilterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Samaj',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Get.back()),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
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
            Container(
              margin: EdgeInsets.only(left: 20, right: 10, bottom: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      filterController.filterSamajList.add('Kadva Patel');
                    },
                    child: FilterPin(
                      keyButton: 'Samaj1',
                      text: 'Kadva Patel',
                      selectValue: false,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FilterPin(
                    keyButton: 'Samaj2',
                    text: 'Leva Patel',
                    selectValue: false,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, bottom: 20),
              child: Row(
                children: [
                  FilterPin(
                    keyButton: 'Samaj3',
                    text: 'Any',
                    selectValue: false,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
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
    );
  }
}
