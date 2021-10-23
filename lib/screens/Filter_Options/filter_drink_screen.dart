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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
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
                    keyButton: 'drink1',
                    text: 'Never',
                    selectValue: false,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FilterPin(
                    keyButton: 'drink2',
                    text: 'Socially',
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
                    keyButton: 'drink3',
                    text: 'Regularly',
                    selectValue: false,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FilterPin(
                    keyButton: 'drink4',
                    text: 'Planning to quit',
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
