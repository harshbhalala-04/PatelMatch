// import 'package:chat/helper/constants.dart';
// import 'package:chat/screens/feed_screen.dart';
// import 'package:chat/screens/filter_screen.dart';
// import 'package:chat/screens/chat_section/message_screen.dart';
// import 'package:chat/screens/nested_tab/tab_one.dart';
// import 'package:chat/screens/profile_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class CustomTabs extends StatefulWidget {
//   // final fromSingleFeed;
//   // final userDataFeed;
//   // final index;

//   // CustomTabs({this.fromSingleFeed = false, this.userDataFeed, this.index});
//   @override
//   _CustomTabsState createState() => _CustomTabsState();
// }

// class _CustomTabsState extends State<CustomTabs> {
//   int _selectedPage = 0;
//   // String? username = '';
//   // String? age = '';
//   // String? height = '';
//   // String? community = '';
//   // String? gender = '';
//   // String? gym = '';
//   // String? education = '';
//   // String? worklife = '';
//   // String? salary = '';
//   // String? drinking = '';
//   // String? smoking = '';
//   // String? zodiacSign = '';
//   // String? politics = '';
//   // String? movies = '';
//   // String? workout = '';
//   PageController? _pageController;

//   void _changePage(int pageNum) {
//     setState(() {
//       _selectedPage = pageNum;
//       _pageController!.animateToPage(
//         pageNum,
//         duration: Duration(milliseconds: 100),
//         curve: Curves.fastLinearToSlowEaseIn,
//       );
//     });
//   }

//   fetchUserGender() async {
//     await FirebaseFirestore.instance
//         .collection("users")
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .get()
//         .then((val) {
//       Constants.gender = val['gender'];
//       // print(Constants.gender);
//       // print('THis is current user gender');
//       // print('This is current user gender');
//     });
//   }

//   // calculateAge() {
//   //   String? month;
//   //   String? day;
//   //   String? year;

//   //   FirebaseFirestore.instance
//   //       .collection("users")
//   //       .doc(FirebaseAuth.instance.currentUser!.uid)
//   //       .get()
//   //       .then((val) {
//   //     final map = val.data();
//   //     if (map!.containsKey('mm')) {
//   //       month = val['mm'];
//   //     }
//   //     if (map.containsKey('dd')) {
//   //       day = val['dd'];
//   //     }
//   //     if (map.containsKey('yyyy')) {
//   //       year = val['yyyy'];
//   //     }
//   //   });
//   //   DateTime currentDate = DateTime.now();
//   //   int age = currentDate.year - int.parse(year!);
//   //   int month1 = currentDate.month;
//   //   int month2 = int.parse(month!);
//   //   if (month2 > month1) {
//   //     age--;
//   //   } else if (month1 == month2) {
//   //     int day1 = currentDate.day;
//   //     int day2 = int.parse(day!);
//   //     if (day2 > day1) {
//   //       age--;
//   //     }
//   //   }
//   //   return age;
//   // }

//   @override
//   void initState() {
//     _pageController = PageController();

//     final FirebaseAuth auth = FirebaseAuth.instance;
//     final User? user = auth.currentUser;
//     final firestore = FirebaseFirestore.instance;
//     print('Init State');
//     firestore.collection("users").doc(user!.uid).get().then((val) {
//       setState(() {
//         Constants.userImage = val['imgUrls'][0];
//         print(Constants.userImage);
//         print('User Image');
//       });
//     });

//     fetchUserGender();

//     // print('This is init State');

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _pageController!.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   vertical: 10.0,
//                 ),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (ctx) => ProfileScreen()));
//                         },
//                         child: CircleAvatar(
//                           backgroundImage: NetworkImage(Constants.userImage),
//                           backgroundColor: Colors.grey,
//                         ),
//                       ),
//                       SizedBox(
//                         width: 16,
//                       ),
//                       Row(
//                         children: [
//                           TabButton(
//                             text: "  Feed  ",
//                             pageNumber: 0,
//                             selectedPage: _selectedPage,
//                             onPressed: () {
//                               _changePage(0);
//                             },
//                           ),
//                           TabButton(
//                             text: "  Requests  ",
//                             pageNumber: 1,
//                             selectedPage: _selectedPage,
//                             onPressed: () {
//                               _changePage(1);
//                             },
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         width: 16,
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (ctx) => FilterScreen()));
//                         },
//                         child: Container(
//                           width: 30,
//                           child: Column(
//                             children: [
//                               SizedBox(
//                                 height: 0,
//                               ),
//                               SvgPicture.asset(
//                                 'iPhone 11 Pro/Vector.svg',
//                                 fit: BoxFit.cover,
//                                 height: 6.94,
//                                 width: 27.69,
//                               ),
//                               SvgPicture.asset(
//                                 'iPhone 11 Pro/Vector-1.svg',
//                                 fit: BoxFit.cover,
//                                 height: 6.94,
//                                 width: 27.69,
//                               ),
//                               SvgPicture.asset(
//                                 'iPhone 11 Pro/Vector-2.svg',
//                                 fit: BoxFit.cover,
//                                 height: 6.94,
//                                 width: 27.69,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 16,
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (ctx) => MessageScreen()));
//                         },
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               height: 4,
//                             ),
//                             SvgPicture.asset(
//                               'assets/iPhone 11 Pro 2/Vector.svg',
//                               height: 31.04,
//                               width: 36.54,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: PageView(
//                   physics: NeverScrollableScrollPhysics(),
//                   onPageChanged: (int page) {
//                     setState(() {
//                       _selectedPage = page;
//                     });
//                   },
//                   controller: _pageController,
//                   children: [
//                     FeedScreen(),
//                     TabOneScreen(),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TabButton extends StatelessWidget {
//   final String? text;
//   final int? selectedPage;
//   final int? pageNumber;
//   final onPressed;
//   TabButton({this.text, this.selectedPage, this.pageNumber, this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           primary: selectedPage == pageNumber
//               ? Color.fromRGBO(255, 85, 115, 1)
//               : Colors.white,
//           shape: RoundedRectangleBorder(
//               borderRadius: text == "  Feed  "
//                   ? BorderRadius.only(
//                       topLeft: Radius.circular(50),
//                       bottomLeft: Radius.circular(50))
//                   : BorderRadius.only(
//                       topRight: Radius.circular(50),
//                       bottomRight: Radius.circular(50))),
//         ),
//         child: Text(
//           text!,
//           style: TextStyle(
//               color: selectedPage == pageNumber
//                   ? Colors.white
//                   : Color.fromRGBO(150, 150, 150, 1)),
//         ));
//   }
// }

import 'package:chat/controllers/screen_controller.dart';
import 'package:chat/screens/chat_section/message_screen.dart';
import 'package:chat/screens/filter_screen.dart';
import 'package:chat/screens/profile_screen.dart';
import 'package:chat/widgets/feed_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'feed_screen.dart';
import 'nested_tab/request_tab.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  final screenController = Get.put(ScreenController());
  PageController? pageController;

  void initState() {
    // TODO: implement initState
    pageController = PageController();
    screenController.fetchUserImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.white,
          leading: Container(
            margin: EdgeInsets.all(4),
            child: Obx(
              () => InkWell(
                onTap: () {
                  Get.to(ProfileScreen());
                },
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage(screenController.userProfileUrl.value),
                  backgroundColor: Colors.grey,
                ),
              ),
            ),
          ),
          centerTitle: true,
          title: Row(
            children: [
              Obx(
                () => TabButton(
                  text: "  Feed  ",
                  pageNumber: 0,
                  selectedPage: screenController.selectedPage.value,
                  onPressed: () {
                    pageController!.animateToPage(0,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.fastLinearToSlowEaseIn);
                  },
                ),
              ),
              Obx(
                () => TabButton(
                  text: "  Requests  ",
                  pageNumber: 1,
                  selectedPage: screenController.selectedPage.value,
                  onPressed: () {
                    pageController!.animateToPage(1,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.fastLinearToSlowEaseIn);
                  },
                ),
              ),
            ],
          ),
          actions: [
            Container(
              width: 30,
              child: Container(
                margin: EdgeInsets.only(top: 12),
                child: InkWell(
                  onTap: () {
                    Get.to(FilterScreen());
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'iPhone 11 Pro/Vector.svg',
                        fit: BoxFit.cover,
                        height: 6.94,
                        width: 27.69,
                      ),
                      SvgPicture.asset(
                        'iPhone 11 Pro/Vector-1.svg',
                        fit: BoxFit.cover,
                        height: 6.94,
                        width: 27.69,
                      ),
                      SvgPicture.asset(
                        'iPhone 11 Pro/Vector-2.svg',
                        fit: BoxFit.cover,
                        height: 6.94,
                        width: 27.69,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 14,
            ),
            InkWell(
              onTap: () {
                Get.to(MessageScreen());
              },
              child: Container(
                margin: EdgeInsets.only(right: 3),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SvgPicture.asset(
                      'assets/iPhone 11 Pro 2/Vector.svg',
                      height: 31.04,
                      width: 36.54,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: PageView(
        physics: new NeverScrollableScrollPhysics(),
        onPageChanged: (int page) {
          screenController.selectedPage.value = page;
        },
        controller: pageController,
        children: [
          FeedScreen(),
          RequestTabScreen(),
        ],
      ),
      floatingActionButton: Obx(() => (screenController.selectedPage.value == 0)
          ? FeedButton()
          : Container()),
    );
  }
}

class TabButton extends StatelessWidget {
  final String? text;
  final int? selectedPage;
  final int? pageNumber;
  final onPressed;
  TabButton({this.text, this.selectedPage, this.pageNumber, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: selectedPage == pageNumber
              ? Color.fromRGBO(255, 85, 115, 1)
              : Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: text == "  Feed  "
                  ? BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50))
                  : BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
        ),
        child: Text(
          text!,
          style: TextStyle(
              color: selectedPage == pageNumber
                  ? Colors.white
                  : Color.fromRGBO(150, 150, 150, 1)),
        ));
  }
}
