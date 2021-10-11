import 'package:chat/controllers/onboarding_screen_controller/request_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../request_screen.dart';
import '../sent_screen.dart';

class RequestTabScreen extends StatefulWidget {
  const RequestTabScreen({Key? key}) : super(key: key);

  @override
  _RequestTabScreenState createState() => _RequestTabScreenState();
}

class _RequestTabScreenState extends State<RequestTabScreen> {
  // int _selectedPage = 0;
  PageController? _pageController;
  final requestTabController = RequestTabController();

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('SelectedPage: $requestTabController.selectedPage');
    return Scaffold(
      body: SafeArea(
        child: BottomAppBar(
          
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: PageView(
                    onPageChanged: (int page) {
                      requestTabController.selectedPage.value = page;
                    },
                    controller: _pageController,
                    children: [
                      RequestScreen(),
                      SentScreen(),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Obx(() => TabButton(
                              text: "Recieved",
                              pageNumber: 0,
                              selectedPage:
                                  requestTabController.selectedPage.value,
                              onPressed: () {
                                requestTabController.changePage(0);
                                _pageController!.animateToPage(
                                  0,
                                  duration: Duration(milliseconds: 100),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                );
                              },
                            )),
                        Obx(() => TabButton(
                              text: "Sent",
                              pageNumber: 1,
                              selectedPage:
                                  requestTabController.selectedPage.value,
                              onPressed: () {
                                requestTabController.changePage(1);
                                _pageController!.animateToPage(
                                  1,
                                  duration: Duration(milliseconds: 100),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                );
                              },
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
    return GestureDetector(
      
      onTap: onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(
          vertical: selectedPage == pageNumber ? 12.0 : 0,
          horizontal: selectedPage == pageNumber ? 30.0 : 0,
        ),
        margin: EdgeInsets.symmetric(
          vertical: selectedPage == pageNumber ? 0 : 12.0,
          horizontal: selectedPage == pageNumber ? 0 : 30.0,
        ),
        child: Text(
          text!,
          style: TextStyle(
            color: selectedPage == pageNumber ? Colors.black87 : Colors.black26,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
