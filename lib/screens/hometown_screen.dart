import 'package:chat/widgets/request_assistant.dart';
import 'package:flutter/material.dart';

class HometownScreen extends StatefulWidget {
  const HometownScreen({Key? key}) : super(key: key);

  @override
  _HometownScreenState createState() => _HometownScreenState();
}

class _HometownScreenState extends State<HometownScreen> {
  TextEditingController _hometownController = new TextEditingController();
  String mapKey = "AIzaSyDQjYMukCgFvf5qIPTUocOBJOlxZJg-0Wg";

  @override
  void dispose() {
    _hometownController.dispose();
    super.dispose();
  }

  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      
      String autoCompleteUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890&components-country:in";

      var res = await RequestAssitant.getRequest(autoCompleteUrl);

      if (res == 'failed') {
        return;
      } else {
        print('Response I got : ');
        print(res);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Hometown',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Whereabouts do you reside in?'),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (val) {
                  findPlace(val);
                },
                controller: _hometownController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search Your hometown',
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(width: 2),
                  ),
                ),
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
                Navigator.pop(context);
              },
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 17),
              ),
              style: ButtonStyle(),
            ),
          ),
        ),
      ),
    );
  }
}
