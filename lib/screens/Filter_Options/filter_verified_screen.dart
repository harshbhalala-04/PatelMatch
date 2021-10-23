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
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Verified',
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
                    keyButton: 'Verify1',
                    text: 'Verified',
                    selectValue: false,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FilterPin(
                    keyButton: 'Verify2',
                    text: 'Non Verified',
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
                    keyButton: 'Verify3',
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
