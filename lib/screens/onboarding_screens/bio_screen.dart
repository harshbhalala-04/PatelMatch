import 'package:chat/database/database.dart';
import 'package:flutter/material.dart';
import '../chat_section/home_screen.dart';


class BioScreen extends StatefulWidget {
  late final email;
  late final username;
  late final password;

  BioScreen({this.email, this.username, this.password});

  @override
  _BioScreenState createState() => _BioScreenState();
}

class _BioScreenState extends State<BioScreen> {
  TextEditingController _textEditingController = new TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: Text(
              'Skip',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              // uploadUserInfo(
              //     widget.email, widget.password, widget.username, '', context);
              DataBaseMethods().addUserBio('');
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => HomeScreen()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                'Enter a short bio',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Tell us bit about yourself, everyone would love to hear!',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  top: 8.0,
                  right: 8.0,
                ),
                child: TextField(
                  controller: _textEditingController,
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(width: 2),
                    ),
                  ),
                  maxLength: 280,
                ),
              ),
              Text('Maximum 280 characters!'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: ElevatedButton(
              onPressed: () {
                String text = _textEditingController.text;
                print(text);
                DataBaseMethods().addUserBio(text);
                // uploadUserInfo(
                //     widget.email, widget.password, widget.username, text, context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => HomeScreen()));
              },
              child: isLoading
                  ? CircularProgressIndicator()
                  : Text(
                      'Continue',
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
