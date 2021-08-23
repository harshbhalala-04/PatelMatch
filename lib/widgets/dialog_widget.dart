import 'package:flutter/material.dart';

class dialogWidget extends StatefulWidget {
  const dialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  _dialogWidgetState createState() => _dialogWidgetState();
}

class _dialogWidgetState extends State<dialogWidget> {
  int bouquetsNo = 12;
  String username = 'Athira';
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    print(deviceWidth);
    print(deviceHeight);

    return Container(
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  child: Text('Buy bouquets',
                      style: TextStyle(
                        color: Colors.pink,
                      )),
                  onPressed: () {},
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  // width: 75,
                  // height: 75,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 0,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 30,
                          color: Color.fromRGBO(0, 0, 0, 0.25)),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    child: Image(
                      fit: BoxFit.cover,
                      height: 50,
                      image: AssetImage('assets/bokay.png'),
                      alignment: Alignment.center,
                      color: Color.fromRGBO(255, 85, 115, 1),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'My bouquets: $bouquetsNo  ',
                    textAlign: TextAlign.center,
                  ),
                  RotationTransition(
                    turns: AlwaysStoppedAnimation(15 / 360),
                    child: Image(
                      height: 18.04,
                      width: 12.39,
                      image: AssetImage('assets/bokay.png'),
                      color: Color.fromRGBO(255, 85, 115, 1),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Enter the number of bouquets ',
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          children: [
                            Text(' you want to send ',
                                style: TextStyle(fontSize: 18)),
                            Text(username,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(255, 85, 115, 1),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 40,
                alignment: Alignment.center,
                child: TextField(
                  //cursorHeight: 24,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  //textAlign: TextAlign.center,

                  expands: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: '00',
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black38),
                          borderRadius: BorderRadius.all(Radius.circular(0)))),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  width: 175,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255,85,115,1)
                  ),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)))),
                      onPressed: () {},
                      child: Text('Send')))
            ],
          ),
        ),
      ),
    );
  }
}
