import 'package:chat/database/database.dart';
import 'package:chat/screens/onboarding_screens/star_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NativeScreen extends StatefulWidget {
  const NativeScreen({Key? key}) : super(key: key);

  @override
  _NativeScreenState createState() => _NativeScreenState();
}

class _NativeScreenState extends State<NativeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
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
                    DataBaseMethods().addUserNative('');
                    Get.to(StarScreen());
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
              'Add Your Native Place',
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
                onChanged: (val) {
                  // findPlace(val);
                },
                decoration: InputDecoration(
                  hintText: 'Start Typing...',
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(width: 2),
                  ),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please Enter Your native place';
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
                Get.to(StarScreen());
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
