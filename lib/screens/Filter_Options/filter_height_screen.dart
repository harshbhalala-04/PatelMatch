import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/helper/services.dart';
import 'package:chat/screens/filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class FilterHeightScreen extends StatefulWidget {
  const FilterHeightScreen({Key? key}) : super(key: key);

  @override
  _FilterHeightScreenState createState() => _FilterHeightScreenState();
}

class _FilterHeightScreenState extends State<FilterHeightScreen> {
  String minHeight = '';
  String maxHeight = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Height',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Get.back()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Choose minimum and maximum height.',
                style: TextStyle(fontSize: 18),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
  
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Minimum Height',
                          style: TextStyle(
                            color: Color.fromRGBO(141, 141, 141, 1),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          decoration: BoxDecoration(
                            border:  Border.all(
                              color: Color.fromRGBO(255, 85, 115, 1),
                              width: 2
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          width: 150,
                          child: SearchableDropdown.single(
                            
                            displayClearIcon: false,
                            isExpanded: true,
                            iconDisabledColor: Color.fromRGBO(255, 85, 115, 1),
                            hint: minHeight == ''
                                ? Text(
                                    'Select',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  )
                                : Text(
                                    minHeight,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                            items: heights,
                            onChanged: (val) {
                              minHeight = val;
                              print(minHeight);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10,),
                    Column(
                      children: [
                        Text(
                          'Maximum Height',
                          style: TextStyle(
                            color: Color.fromRGBO(141, 141, 141, 1),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          decoration: BoxDecoration(
                            border:  Border.all(
                              color: Color.fromRGBO(255, 85, 115, 1),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          width: 140,
                          child: SearchableDropdown.single(
                            isExpanded: true,
                            displayClearIcon: false,
                            hint: minHeight == ''
                                ? Text(
                                    'Select',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  )
                                : Text(
                                    minHeight,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                            items: heights,
                            onChanged: (val) {
                              minHeight = val;
                              print(minHeight);
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
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
              List<dynamic> height = [];
              height.add(minHeight);
              height.add(maxHeight);
              Get.find<GlobalController>().currentAppuser.value.filters!.height =
                  height;
              DataBaseMethods()
                  .filterHeight(minHeight, maxHeight);
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
