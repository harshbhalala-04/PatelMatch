import 'package:chat/database/database.dart';
import 'package:chat/screens/onboarding_screens/manglic_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GotraScreen extends StatefulWidget {
  const GotraScreen({Key? key}) : super(key: key);

  @override
  _GotraScreenState createState() => _GotraScreenState();
}

class _GotraScreenState extends State<GotraScreen> {
  TextEditingController gotraController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          TextButton(
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    DataBaseMethods().addUserGotra('');
                    Get.to(ManglicScreen());
                  },
                )
        ],
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
              'Enter Your Gotra',
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
                controller: gotraController,
                decoration: InputDecoration(
                  hintText: 'Start Typing...',
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(width: 2),
                  ),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please Enter Your Gotra';
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
                String username = gotraController.text;

                DataBaseMethods().addUserGotra(username);
                Get.to(ManglicScreen());
              },
              child: Text('Continue',
                  style: TextStyle(fontSize: 17), textAlign: TextAlign.center),
              style: ButtonStyle(),
            ),
          ),
        ),
      ),
    );
  }
}
