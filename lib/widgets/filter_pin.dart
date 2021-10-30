import 'package:chat/controllers/filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterPin extends StatefulWidget {
  final String keyButton;
  final String text;
  bool selectValue;
  FilterPin(
      {required this.keyButton, required this.text, required this.selectValue});

  @override
  _FilterPinState createState() => _FilterPinState();
}

class _FilterPinState extends State<FilterPin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 50,
      decoration: widget.selectValue
          ? BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(255, 71, 104, 1),
                Color.fromRGBO(255, 115, 140, 1)
              ]),
              borderRadius: BorderRadius.circular(50))
          : BoxDecoration(),
      child: FloatingActionButton(
        heroTag: widget.keyButton,
        onPressed: () {
          setState(() {
            widget.selectValue = !widget.selectValue;
            if (widget.selectValue) {
              Get.find<FilterController>().filterSamajList.add(widget.text);
            } else {
              Get.find<FilterController>().filterSamajList.remove(widget.text);
            }
          });
        },
        child: Text(
          widget.text,
          style: TextStyle(fontSize: 18, color: Color.fromRGBO(51, 51, 51, 1)),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        backgroundColor: Colors.white,
      ),
    );
  }
}
