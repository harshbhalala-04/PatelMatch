import 'package:chat/database/database.dart';
import 'package:chat/screens/user_profile_edit/height_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({Key? key}) : super(key: key);

  @override
  _WeightScreenState createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  TextEditingController _weightController = new TextEditingController();

  void showDialog() {
    Get.defaultDialog(
      middleText: "Plese Select Your Weight",
      title: "",
      middleTextStyle: TextStyle(fontSize: 20),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('Close'),
                style: TextButton.styleFrom(
                  textStyle: TextStyle(fontSize: 16)
                )
              ),
          ],
        )
      ],
      barrierDismissible: false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Enter Your Weight',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _weightController,
                decoration: InputDecoration(
                  hintText: 'Start Typing...',
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(width: 2),
                  ),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please Enter Your Weight';
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40))),
            child: ElevatedButton(
              onPressed: () {
                String weight = _weightController.text;
                if (weight.isEmpty) {
                  showDialog();
                } else {
                  DataBaseMethods().addUserWeight(weight);
                  Get.to(HeightScreen(fromProfile: false,));
                }
              },
              child: 
                   Text('Continue',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.center),
              style: ButtonStyle(),
            ),
          ),
        ),
      ),
    );
  }
}
