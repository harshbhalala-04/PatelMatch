import 'package:chat/screens/filter_screen.dart';
import 'package:chat/widgets/filter_pin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterIncomeScreen extends StatefulWidget {
  const FilterIncomeScreen({Key? key}) : super(key: key);

  @override
  _FilterIncomeScreenState createState() => _FilterIncomeScreenState();
}

class _FilterIncomeScreenState extends State<FilterIncomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Income Range',
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
                  FilterPin(
                    keyButton: 'Income1',
                    text: '0 - 2.5 Lpa',
                    selectValue: false,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FilterPin(
                    keyButton: 'Income2',
                    text: '2.5 - 5 Lpa',
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
                    keyButton: 'Income3',
                    text: '5 - 7.5 Lpa',
                    selectValue: false,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FilterPin(
                    keyButton: 'Income4',
                    text: '7.5 - 10 Lpa',
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
                    keyButton: 'Income5',
                    text: 'Above 10 Lpa',
                    selectValue: false,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FilterPin(
                    keyButton: 'Income6',
                    text: 'Any',
                    selectValue: false,
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
