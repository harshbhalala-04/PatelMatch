import 'package:chat/controllers/global_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/helper/services.dart';
import 'package:chat/screens/filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';

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
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromRGBO(255, 85, 115, 1),
                                  width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          width: 150,
                          child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            showSelectedItems: true,
                            showSearchBox: true,
                            items: heights,
                            // ignore: deprecated_member_use
                            label: "Select",
                            // popupItemDisabled: (String s) =>
                            //     s.startsWith('I'),
                            onChanged: (val) {
                              minHeight = val!;
                            },
                            // selectedItem: "Brazil"
                          ),
                          // child: SearchableDropdown.single(
                          //   displayClearIcon: false,
                          //   isExpanded: true,
                          //   iconDisabledColor: Color.fromRGBO(255, 85, 115, 1),
                          //   hint: minHeight == ''
                          //       ? Text(
                          //           'Select',
                          //           style: TextStyle(
                          //             fontSize: 18,
                          //           ),
                          //         )
                          //       : Text(
                          //           minHeight,
                          //           style: TextStyle(
                          //             color: Colors.black,
                          //             fontSize: 18,
                          //           ),
                          //         ),
                          // items: heights,
                          // onChanged: (val) {
                          //   minHeight = val;

                          //   print(minHeight);
                          // },
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          'Maximum Height',
                          style: TextStyle(
                            color: Color.fromRGBO(141, 141, 141, 1),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromRGBO(255, 85, 115, 1),
                                width: 2,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          width: 140,
                          child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            showSelectedItems: true,
                            showSearchBox: true,
                            items: heights,
                            // ignore: deprecated_member_use
                            label: "Select",
                            // popupItemDisabled: (String s) =>
                            //     s.startsWith('I'),
                            onChanged: (val) {
                              maxHeight = val!;
                            },
                            // selectedItem: "Brazil"
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
              int intValue1 =
                  int.parse(minHeight.replaceAll(RegExp('[^0-9]'), ''));
              int intValue2 =
                  int.parse(maxHeight.replaceAll(RegExp('[^0-9]'), ''));
              if (intValue1 > intValue2) {
                Get.defaultDialog(
                  middleText: "Plese Select Valid Height Range",
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
                                textStyle: TextStyle(fontSize: 16))),
                      ],
                    )
                  ],
                  barrierDismissible: false,
                );
              } else {
                List<dynamic> height = [];
                print(minHeight);
                print(maxHeight);
                height.add(minHeight);
                height.add(maxHeight);
                Get.find<GlobalController>()
                    .currentAppuser
                    .value
                    .filters!
                    .height = height;
                DataBaseMethods().filterHeight(minHeight, maxHeight);
                Get.off(FilterScreen());
              }
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
