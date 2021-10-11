import 'package:chat/controllers/global_controller.dart';
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
  final globalController = Get.put(GlobalController());
  final screenController = Get.put(ScreenController());

  PageController? pageController;

  void initState() {
    // TODO: implement initState
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.all(4),
                    child: Obx(() => InkWell(
                          onTap: () {
                            Get.to(ProfileScreen());
                          },
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                screenController.userProfileUrl.value),
                            backgroundColor: Colors.grey,
                          ),
                        )),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                  Container(
                    width: 30,
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
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
            ],
          ),
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
      // floatingActionButton: Obx(() => (screenController.selectedPage.value == 0)
      //     ? FeedButton(index: 0)
      //     : Container()),
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
