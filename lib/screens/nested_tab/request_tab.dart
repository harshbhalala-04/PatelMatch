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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 238, 241, 1),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() => GestureDetector(
                          onTap: () {
                            requestTabController.changePage(0);
                            _pageController!.animateToPage(
                              0,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.ease,
                            );
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            curve: Curves.ease,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: requestTabController.selectedPage.value == 0
                                  ? Color.fromRGBO(255, 85, 115, 1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text(
                                "Received",
                                style: TextStyle(
                                  color: requestTabController.selectedPage.value == 0
                                      ? Colors.white
                                      : Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        )),
                  ),
                  Expanded(
                    child: Obx(() => GestureDetector(
                          onTap: () {
                            requestTabController.changePage(1);
                            _pageController!.animateToPage(
                              1,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.ease,
                            );
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            curve: Curves.ease,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: requestTabController.selectedPage.value == 1
                                  ? Color.fromRGBO(255, 85, 115, 1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text(
                                "Sent",
                                style: TextStyle(
                                  color: requestTabController.selectedPage.value == 1
                                      ? Colors.white
                                      : Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
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
          ],
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
