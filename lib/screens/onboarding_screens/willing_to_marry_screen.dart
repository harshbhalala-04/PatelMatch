import 'package:chat/database/database.dart';
import 'package:chat/screens/onboarding_screens/user_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum MarryToSamaj { SameSamaj, AnySamaj }

class WillingToMarryScreen extends StatefulWidget {
  const WillingToMarryScreen({Key? key}) : super(key: key);

  @override
  _WillingToMarryScreenState createState() => _WillingToMarryScreenState();
}

class _WillingToMarryScreenState extends State<WillingToMarryScreen> {
  MarryToSamaj? _reply;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _reply = MarryToSamaj.SameSamaj;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PM',
          style:
              TextStyle(color: Color.fromRGBO(255, 85, 115, 1), fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Willing to marry from',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = MarryToSamaj.SameSamaj;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: MarryToSamaj.SameSamaj,
                    groupValue: _reply,
                    onChanged: (MarryToSamaj? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Same Samaj'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _reply = MarryToSamaj.AnySamaj;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: MarryToSamaj.AnySamaj,
                    groupValue: _reply,
                    onChanged: (MarryToSamaj? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                  ),
                  Text('Any Samaj'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: ElevatedButton(
              onPressed: () {
                if (_reply == MarryToSamaj.SameSamaj) {
                  DataBaseMethods().addUserMarryToSamaj("Same Samaj");
                } else {
                  DataBaseMethods().addUserMarryToSamaj("Any Samaj");
                }
                Get.to(UserNameScreen(relation: ' ', fromProfile: false));
              },
              child: Text(
                'Continue',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(255, 85, 115, 0.89),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
