import 'package:chat/helper/constants.dart';
import 'package:chat/widgets/database_method.dart';
import 'package:chat/widgets/dialog_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SingleUserFeed extends StatefulWidget {
  List<Map<String, dynamic>> userData;

  SingleUserFeed({
    required this.userData,
  });

  @override
  _SingleUserFeedState createState() => _SingleUserFeedState();
}

class _SingleUserFeedState extends State<SingleUserFeed>
    with TickerProviderStateMixin {
  MatchEngine? _matchEngine;
  int currentIndex = 0;
  List<SwipeItem> _swipeItems = [];
  bool isLoading = false;
  var age;
  String? userAge = '';
  int endOfUsers = 0;
  int count = 0;
  int temp = 0;
  int fetch = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  calculateAge(String month, String day, String year) async {
    setState(() {
      isLoading = true;
    });

    DateTime currentDate = DateTime.now();
    age = currentDate.year - int.parse(year);
    int month1 = currentDate.month;
    int month2 = int.parse(month);
    if (month2 > month1) {
      age = age - 1;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = int.parse(day);
      if (day2 > day1) {
        age = age - 1;
      }
    }

    setState(() {
      userAge = age.toString();
      isLoading = false;
    });
  }

  removeUser() {
    currentIndex = currentIndex + 1;
  }

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    for (int i = 0; i < widget.userData.length; i++) {
      _swipeItems.add(SwipeItem(
          content: widget.userData[i],
          likeAction: () {
            _scaffoldKey.currentState!.setState(() {
              Constants.userProfileIds
                  .add(widget.userData[currentIndex]['uid']);
              DataBaseMethods().addRequestMethod(
                  Constants.myName,
                  widget.userData[currentIndex]['username'],
                  fetch,
                  widget.userData[currentIndex]['imgUrls'][0],
                  widget.userData[currentIndex]['uid']);
              fetch = 1;
              //index = index + 1;
              count = count + 1;
              temp = 1;
              currentIndex = currentIndex + 1;
              //removeUser();
            });
          },
          superlikeAction: () {},
          nopeAction: () {
            _scaffoldKey.currentState!.setState(() {
              //index = index + 1;
              count = count + 1;
              temp = 1;
              DataBaseMethods().addDeclineMethod(
                  widget.userData[currentIndex]['uid'],
                  widget.userData[currentIndex]['username']);

              currentIndex = currentIndex + 1;

              // fetchUserImageOne(2);

              //removeUser();
            });
          }));
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);

    // fetchUserImage(
    //   index,
    //   "notFromDecline",
    // );

    print(_swipeItems.length);

    calculateAge(widget.userData[currentIndex]['mm'], widget.userData[currentIndex]['dd'], widget.userData[currentIndex]['yyyy']);

    print('Here init state is completed!!!!!!!!!!!!!!!!!');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    delayFunction() async {
      await Future.delayed(Duration(milliseconds: 3000));
    }

    if (widget.userData[currentIndex]['imgUrls']!.length == 0) {
      delayFunction();
    }

    print('Here it enters in widget');
    return SafeArea(
      child: Scaffold(
        // key: _scaffoldKey,
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : /*widget.userData.length == 0*/ endOfUsers == 1
                ? Center(
                    child: Text('No user Found!'),
                  )
                : SwipeCards(
                    matchEngine: _matchEngine!,
                    onStackFinished: () {
                      print('Stack Finished');
                      endOfUsers = 1;
                    },
                    itemBuilder: (context, indexOfCard) {
                      print('This is index of card : $indexOfCard');
                      return Container(
                        height: screenSize.height,
                        width: screenSize.width,
                        child: Card(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  height: screenSize.height,
                                  width: screenSize.width,
                                  fit: BoxFit.cover,
                                  imageUrl: widget.userData[currentIndex][0],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 23.0,
                                    top: 12,
                                    bottom: 12,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${widget.userData[currentIndex]['username']}, $userAge',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 23,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_sharp,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        'Surat, India',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12, left: 23, right: 22, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Personal Information',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        'Ex - Zerodha, Ex - Grant Thornton. I used to crunch numbers and value companies for a living, now I’m trying to build one.',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    children: [
                                      widget.userData[currentIndex]
                                              .containsKey('height')
                                          ? Container(
                                              width: 150,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: ListTile(
                                                  title: Text(
                                                    'Height',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 10),
                                                  ),
                                                  subtitle: Text(
                                                    widget.userData[
                                                        currentIndex]['height'],
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 0,
                                            ),
                                      widget.userData[currentIndex]
                                              .containsKey('height')
                                          ? SizedBox(width: 20)
                                          : SizedBox(
                                              width: 0,
                                            ),
                                      widget.userData[currentIndex]
                                              .containsKey('community')
                                          ? Container(
                                              width: 150,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: ListTile(
                                                  title: Text(
                                                    'Community',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 10),
                                                  ),
                                                  subtitle: Text(
                                                    widget.userData[
                                                            currentIndex]
                                                        ['community'],
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 0,
                                            ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    children: [
                                      widget.userData[currentIndex]
                                              .containsKey('gender')
                                          ? Container(
                                              width: 150,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: ListTile(
                                                  title: Text(
                                                    'Gender',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 10),
                                                  ),
                                                  subtitle: Text(
                                                    widget.userData[
                                                                currentIndex]
                                                            .containsKey(
                                                                'gender')
                                                        ? widget.userData[
                                                                currentIndex]
                                                            ['gender']
                                                        : '',
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 0,
                                            ),
                                      widget.userData[currentIndex]
                                              .containsKey('height')
                                          ? SizedBox(width: 20)
                                          : SizedBox(
                                              width: 0,
                                            ),
                                      widget.userData[currentIndex]
                                              .containsKey('workout')
                                          ? Container(
                                              width: 150,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: ListTile(
                                                  title: Text(
                                                    'Workout',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 10),
                                                  ),
                                                  subtitle: Text(
                                                    widget.userData[
                                                                currentIndex]
                                                            .containsKey(
                                                                'workout')
                                                        ? widget.userData[
                                                                currentIndex]
                                                            ['workout']
                                                        : '',
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 0,
                                            ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                //imgUrls![1] == ''
                                widget.userData[currentIndex][1] == ''
                                    ? Container(
                                        height: 0,
                                      )
                                    : Container(
                                        height: 569,
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          fit: BoxFit.cover,
                                          //imageUrl: imgUrls![1],
                                          imageUrl:
                                              widget.userData[currentIndex][1],
                                        ),
                                      ),
                                widget.userData[currentIndex]
                                            .containsKey('education') ||
                                        widget.userData[currentIndex]
                                            .containsKey('worklife') ||
                                        widget.userData[currentIndex]
                                            .containsKey('salary')
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12,
                                            left: 23,
                                            right: 22,
                                            bottom: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Professional Information',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        height: 0,
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    children: [
                                      widget.userData[currentIndex]
                                              .containsKey('education')
                                          ? Container(
                                              width: 150,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: ListTile(
                                                  title: Text(
                                                    'Education',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 10),
                                                  ),
                                                  subtitle: Text(
                                                    widget.userData[
                                                                currentIndex]
                                                            .containsKey(
                                                                'education')
                                                        ? widget.userData[
                                                                currentIndex]
                                                            ['education']
                                                        : '',
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 0,
                                            ),
                                      widget.userData[currentIndex]
                                              .containsKey('education')
                                          ? SizedBox(width: 20)
                                          : SizedBox(
                                              width: 0,
                                            ),
                                      widget.userData[currentIndex]
                                              .containsKey('worklife')
                                          ? Container(
                                              width: 150,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: ListTile(
                                                  title: Text(
                                                    'Worklife',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 10),
                                                  ),
                                                  subtitle: Text(
                                                    widget.userData[
                                                                currentIndex]
                                                            .containsKey(
                                                                'worklife')
                                                        ? widget.userData[
                                                                currentIndex]
                                                            ['worklife']
                                                        : '',
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 0,
                                            ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    children: [
                                      widget.userData[currentIndex]
                                              .containsKey('salary')
                                          ? Container(
                                              width: 150,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: ListTile(
                                                  title: Text(
                                                    'Salary',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 10),
                                                  ),
                                                  subtitle: Text(
                                                    widget.userData[
                                                                currentIndex]
                                                            .containsKey(
                                                                'salary')
                                                        ? widget.userData[
                                                                currentIndex]
                                                            ['salary']
                                                        : '',
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 0,
                                            ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                //imgUrls![2] == ''
                                widget.userData[currentIndex][2] == ''
                                    ? Container(
                                        height: 0,
                                      )
                                    : Container(
                                        height: 569,
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          fit: BoxFit.cover,
                                          //imageUrl: imgUrls![2],
                                          imageUrl:
                                              widget.userData[currentIndex][2],
                                        ),
                                      ),
                                widget.userData[currentIndex]
                                            .containsKey('drink') ||
                                        widget.userData[currentIndex]
                                            .containsKey('smoke')
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12,
                                            left: 23,
                                            right: 22,
                                            bottom: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Social Life',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        height: 0,
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    children: [
                                      widget.userData[currentIndex]
                                              .containsKey('drink')
                                          ? Container(
                                              width: 150,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: ListTile(
                                                  title: Text(
                                                    'Drinking',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 10),
                                                  ),
                                                  subtitle: Text(
                                                    widget.userData[
                                                                currentIndex]
                                                            .containsKey(
                                                                'drink')
                                                        ? widget.userData[
                                                                currentIndex]
                                                            ['drink']
                                                        : '',
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 0,
                                            ),
                                      widget.userData[currentIndex]
                                              .containsKey('drink')
                                          ? SizedBox(width: 20)
                                          : SizedBox(
                                              width: 0,
                                            ),
                                      widget.userData[currentIndex]
                                              .containsKey('smoke')
                                          ? Container(
                                              width: 150,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: ListTile(
                                                  title: Text(
                                                    'Smoking',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 10),
                                                  ),
                                                  subtitle: Text(
                                                    widget.userData[
                                                                currentIndex]
                                                            .containsKey(
                                                                'smoke')
                                                        ? widget.userData[
                                                                currentIndex]
                                                            ['smoke']
                                                        : '',
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 0,
                                            ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                //imgUrls![3] == ''
                                widget.userData[currentIndex][3] == ''
                                    ? Container(
                                        height: 0,
                                      )
                                    : Container(
                                        height: 569,
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          fit: BoxFit.cover,
                                          //imageUrl: imgUrls![3],
                                          imageUrl:
                                              widget.userData[currentIndex][3],
                                        ),
                                      ),
                                widget.userData[currentIndex]
                                            .containsKey('zodiacSign') ||
                                        widget.userData[currentIndex]
                                            .containsKey('politics') ||
                                        widget.userData[currentIndex]
                                            .containsKey('movies')
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12,
                                            left: 23,
                                            right: 22,
                                            bottom: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Others',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        height: 0,
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    children: [
                                      widget.userData[currentIndex]
                                              .containsKey('zodiacSign')
                                          ? Container(
                                              width: 150,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: ListTile(
                                                  title: Text(
                                                    'Zodiac Sign',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 10),
                                                  ),
                                                  subtitle: Text(
                                                    widget.userData[
                                                                currentIndex]
                                                            .containsKey(
                                                                'zodiacSign')
                                                        ? widget.userData[
                                                                currentIndex]
                                                            ['zodiacSign']
                                                        : '',
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 0,
                                            ),
                                      widget.userData[currentIndex]
                                              .containsKey('zodiacSign')
                                          ? SizedBox(width: 20)
                                          : SizedBox(
                                              width: 0,
                                            ),
                                      widget.userData[currentIndex]
                                              .containsKey('politics')
                                          ? Container(
                                              width: 150,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: ListTile(
                                                  title: Text(
                                                    'Political inclination',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 10),
                                                  ),
                                                  subtitle: Text(
                                                    widget.userData[
                                                                currentIndex]
                                                            .containsKey(
                                                                'politics')
                                                        ? widget.userData[
                                                                currentIndex]
                                                            ['politics']
                                                        : '',
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 0,
                                            ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    children: [
                                      widget.userData[currentIndex]
                                              .containsKey('movies')
                                          ? Container(
                                              width: 150,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: ListTile(
                                                  title: Text(
                                                    'Movies',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 10),
                                                  ),
                                                  subtitle: Text(
                                                    widget.userData[
                                                                currentIndex]
                                                            .containsKey(
                                                                'movies')
                                                        ? widget.userData[
                                                                currentIndex]
                                                            ['movies']
                                                        : '',
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 0,
                                            ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                //imgUrls![4] == ''
                                widget.userData[currentIndex][4] == ''
                                    ? Container(
                                        height: 0,
                                      )
                                    : Container(
                                        height: 569,
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          fit: BoxFit.cover,
                                          //imageUrl: imgUrls![4],
                                          imageUrl:
                                              widget.userData[currentIndex][4],
                                        ),
                                      ),
                                SizedBox(
                                  height: 20,
                                ),
                                //imgUrls![5] == ''
                                widget.userData[currentIndex][5] == ''
                                    ? Container(
                                        height: 0,
                                      )
                                    : Container(
                                        height: 569,
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          fit: BoxFit.cover,
                                          //imageUrl: imgUrls![5],
                                          imageUrl:
                                              widget.userData[currentIndex][5],
                                        ),
                                      ),
                                SizedBox(
                                  height: 80,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
        floatingActionButton: widget.userData.length == 0
            ? Container()
            : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      _matchEngine!.currentItem!.superlikeAction!();
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(255, 71, 104, 1),
                                Color.fromRGBO(255, 115, 140, 1)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image(
                            image: AssetImage('assets/bokay.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 130,
                        height: 45,
                        child: FloatingActionButton(
                          onPressed: () {
                            _matchEngine!.currentItem!.nopeAction!();
                          },
                          child: Text(
                            'Decline',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(184, 184, 184, 1)),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 130,
                        height: 45,
                        child: FloatingActionButton(
                          onPressed: () {
                            _matchEngine!.currentItem!.likeAction!();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(255, 71, 104, 1),
                                  Color.fromRGBO(255, 115, 140, 1)
                                ]),
                                borderRadius: BorderRadius.circular(50)),
                            child: Container(
                              width: 130,
                              height: 45,
                              alignment: Alignment.center,
                              child: Text(
                                'Connect',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
