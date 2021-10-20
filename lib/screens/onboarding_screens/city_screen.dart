import 'package:chat/helper/services.dart';
import 'package:chat/screens/onboarding_screens/star_screen.dart';
import 'package:chat/widgets/request_assistant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  void showDialog() {
    Get.defaultDialog(
      middleText: "Plese Select Your Current Residance",
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
                style:
                    TextButton.styleFrom(textStyle: TextStyle(fontSize: 16))),
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
              'Current City of Residence',
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
                    return 'Please Enter Your current residance';
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

  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      String autoCompleteUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&location=37.76999%2C-122.44696&radius=500&strictbounds=true&types=establishment&key=$mapKey";

      var res = await RequestAssitant.getRequest(autoCompleteUrl);

      if (res == "failed") {
        return;
      }
      print("Places prediction:");
      print(res);
    }
  }
}
