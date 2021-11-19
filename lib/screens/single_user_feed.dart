import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/controllers/feed_screen_controller.dart';
import 'package:chat/controllers/global_controller.dart';
import 'package:chat/controllers/report_controller.dart';
import 'package:chat/database/database.dart';
import 'package:chat/helper/user_modal.dart';
import 'package:chat/main.dart';
import 'package:chat/widgets/info_title.dart';
import 'package:chat/widgets/report_option.dart';
import 'package:chat/widgets/user_image_card.dart';
import 'package:chat/widgets/user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class SingleUserFeed extends StatelessWidget {
  final UserModel currentUser;
  final int userImagesLength;
  final int index;
  SingleUserFeed(
      {required this.currentUser,
      required this.userImagesLength,
      required this.index});

  final reportController = Get.put(ReportController());
  final feedScreenController = Get.put(FeedScreenController());
  final globalController = Get.put(GlobalController());
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return AutoScrollTag(
      key: ValueKey(index),
      controller: Get.find<FeedScreenController>().scrollController,
      index: index,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  height: screenSize.height,
                  width: screenSize.width,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                  imageUrl: currentUser.imgUrl ?? '',
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
                        '${currentUser.username}, ${currentUser.age}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                currentUser.currentCity == null
                    ? Container()
                    : Padding(
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
                              currentUser.currentCity!,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(left: 23, bottom: 10),
                  child: Row(
                    children: [
                      Text(
                        'Profile Created By: ',
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 80,
                        height: 20,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            primary: Colors.white,
                          ),
                          onPressed: () {},
                          child: Text(
                            currentUser.profileCreatedBy!,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(255, 85, 115, 1)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 23, bottom: 10),
                  child: Text(
                    'Personal Information',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      UserInfoCard(title: 'Samaj', subTitle: currentUser.samaj),
                      currentUser.samaj != null && currentUser.samaj != ''
                          ? SizedBox(width: 20)
                          : SizedBox(
                              width: 0,
                            ),
                      UserInfoCard(title: 'Community', subTitle: 'Community')
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
                      UserInfoCard(
                          title: 'Gender', subTitle: currentUser.gender),
                      currentUser.gender != null
                          ? SizedBox(width: 20)
                          : SizedBox(
                              width: 0,
                            ),
                      UserInfoCard(title: 'Workout', subTitle: 'Workout'),
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
                      UserInfoCard(
                          title: 'Height', subTitle: currentUser.height),
                      currentUser.height != null && currentUser.height != ''
                          ? SizedBox(width: 20)
                          : SizedBox(
                              width: 0,
                            ),
                      UserInfoCard(
                          title: 'weight', subTitle: currentUser.weight)
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
                      UserInfoCard(
                          title: 'Handicapped',
                          subTitle: currentUser.handicapped),
                      currentUser.handicapped != null &&
                              currentUser.handicapped != ''
                          ? SizedBox(width: 20)
                          : SizedBox(
                              width: 0,
                            ),
                      currentUser.maritalStatus == null ||
                              currentUser.maritalStatus == ''
                          ? Container()
                          : UserInfoCard(
                              title: 'Marital Status',
                              subTitle: currentUser.maritalStatus)
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
                      UserInfoCard(title: 'NRI', subTitle: currentUser.userNRI),
                      currentUser.userNRI != null && currentUser.userNRI != ''
                          ? SizedBox(width: 20)
                          : SizedBox(
                              width: 0,
                            ),
                      currentUser.nativeCity == null ||
                              currentUser.nativeCity == ''
                          ? Container()
                          : UserInfoCard(
                              title: 'Native Place',
                              subTitle: currentUser.nativeCity),
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
                      currentUser.currentCity == null ||
                              currentUser.currentCity == ''
                          ? Container()
                          : UserInfoCard(
                              title: 'Current City Of Residence',
                              subTitle: currentUser.currentCity),
                      currentUser.currentCity != null &&
                              currentUser.currentCity != ''
                          ? SizedBox(width: 20)
                          : SizedBox(
                              width: 0,
                            ),
                      currentUser.star == null || currentUser.star == ''
                          ? Container()
                          : UserInfoCard(
                              title: 'Star', subTitle: currentUser.star),
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
                      currentUser.gotra == null || currentUser.gotra == ''
                          ? Container()
                          : UserInfoCard(
                              title: 'Gotra', subTitle: currentUser.gotra),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                userImagesLength < 2
                    ? Container(
                        height: 0,
                      )
                    : UserImageCard(image: currentUser.imgUrls![1]),
                (currentUser.education != null &&
                            currentUser.education != '') ||
                        (currentUser.worklife != '' &&
                            currentUser.worklife != null) ||
                        (currentUser.salary != '' && currentUser.salary != null)
                    ? InfoTitle(title: 'Professional Information')
                    : Container(
                        height: 0,
                      ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      currentUser.education == null ||
                              currentUser.education == ''
                          ? Container()
                          : UserInfoCard(
                              title: 'Education',
                              subTitle: currentUser.education),
                      currentUser.education != null &&
                              currentUser.education != ''
                          ? SizedBox(width: 20)
                          : SizedBox(
                              width: 0,
                            ),
                      currentUser.worklife == null || currentUser.worklife == ''
                          ? Container()
                          : UserInfoCard(
                              title: 'Worklife',
                              subTitle: currentUser.worklife),
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
                      currentUser.salary == null || currentUser.salary == ''
                          ? Container()
                          : UserInfoCard(
                              title: 'Salary', subTitle: currentUser.salary),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                userImagesLength < 3
                    ? Container(
                        height: 0,
                      )
                    : UserImageCard(image: currentUser.imgUrls![2]),
                (currentUser.drink != null && currentUser.drink != '') ||
                        (currentUser.smoke != null && currentUser.smoke != '')
                    ? InfoTitle(title: 'Social Life')
                    : Container(
                        height: 0,
                      ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      currentUser.drink == null || currentUser.drink == ''
                          ? Container()
                          : UserInfoCard(
                              title: 'Drink', subTitle: currentUser.drink),
                      currentUser.drink != null && currentUser.drink != ''
                          ? SizedBox(width: 20)
                          : SizedBox(
                              width: 0,
                            ),
                      currentUser.smoke == null || currentUser.smoke == ''
                          ? Container()
                          : UserInfoCard(
                              title: 'Smoke', subTitle: currentUser.smoke)
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                userImagesLength < 4
                    ? Container(
                        height: 0,
                      )
                    : UserImageCard(image: currentUser.imgUrls![3]),
                (currentUser.zodiacSign != null &&
                            currentUser.zodiacSign != '') ||
                        (currentUser.politics != null &&
                            currentUser.politics != '') ||
                        (currentUser.movie != '' && currentUser.movie != null)
                    ? InfoTitle(title: 'Others')
                    : Container(
                        height: 0,
                      ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      currentUser.zodiacSign == null ||
                              currentUser.zodiacSign == ''
                          ? Container()
                          : UserInfoCard(
                              title: 'Zodiac Sign',
                              subTitle: currentUser.zodiacSign),
                      currentUser.zodiacSign == null &&
                              currentUser.zodiacSign == ''
                          ? SizedBox(width: 20)
                          : SizedBox(
                              width: 0,
                            ),
                      currentUser.politics == null || currentUser.politics == ''
                          ? Container()
                          : UserInfoCard(
                              title: 'Political inclination',
                              subTitle: currentUser.politics)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      currentUser.movie == null || currentUser.movie == ''
                          ? Container()
                          : UserInfoCard(
                              title: 'Movies', subTitle: currentUser.movie),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                userImagesLength < 5
                    ? Container(
                        height: 0,
                      )
                    : UserImageCard(image: currentUser.imgUrls![4]),
                SizedBox(
                  height: 20,
                ),
                userImagesLength < 6
                    ? Container(
                        height: 0,
                      )
                    : UserImageCard(image: currentUser.imgUrls![5]),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 45,
                      child: ElevatedButton(
                        key: Key('Report Button'),
                        onPressed: () {
                          Get.dialog(
                            AlertDialog(
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Report this profile',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Obx(() => InkWell(
                                          onTap: () {
                                            Get.find<ReportController>()
                                                .option1
                                                .value = true;
                                            Get.find<ReportController>()
                                                .option2
                                                .value = false;
                                            Get.find<ReportController>()
                                                .option3
                                                .value = false;
                                            Get.find<ReportController>()
                                                .option4
                                                .value = false;
                                            Get.find<ReportController>()
                                                .option5
                                                .value = false;
                                            Get.find<ReportController>()
                                                .repoartReason
                                                .value = 'Fake Profile';
                                          },
                                          child: Container(
                                              width: 230,
                                              height: 50,
                                              decoration: Get.find<
                                                          ReportController>()
                                                      .option1
                                                      .value
                                                  ? BoxDecoration(
                                                      border: Border.all(
                                                        color: Color.fromRGBO(
                                                            255, 85, 115, 1),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)))
                                                  : BoxDecoration(),
                                              child: ReportOption(
                                                  option: 'Fake Profile')),
                                        )),
                                    Obx(() => InkWell(
                                          onTap: () {
                                            Get.find<ReportController>()
                                                .option1
                                                .value = false;
                                            Get.find<ReportController>()
                                                .option2
                                                .value = true;
                                            Get.find<ReportController>()
                                                .option3
                                                .value = false;
                                            Get.find<ReportController>()
                                                .option4
                                                .value = false;
                                            Get.find<ReportController>()
                                                .option5
                                                .value = false;
                                            Get.find<ReportController>()
                                                    .repoartReason
                                                    .value =
                                                'Inappropriate images/content';
                                          },
                                          child: Container(
                                              width: 230,
                                              height: 50,
                                              decoration: Get.find<
                                                          ReportController>()
                                                      .option2
                                                      .value
                                                  ? BoxDecoration(
                                                      border: Border.all(
                                                        color: Color.fromRGBO(
                                                            255, 85, 115, 1),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)))
                                                  : BoxDecoration(),
                                              child: ReportOption(
                                                  option:
                                                      'Inappropriate images/content')),
                                        )),
                                    Obx(() => InkWell(
                                          onTap: () {
                                            Get.find<ReportController>()
                                                .option1
                                                .value = false;
                                            Get.find<ReportController>()
                                                .option2
                                                .value = false;
                                            Get.find<ReportController>()
                                                .option3
                                                .value = true;
                                            Get.find<ReportController>()
                                                .option4
                                                .value = false;
                                            Get.find<ReportController>()
                                                .option5
                                                .value = false;
                                            Get.find<ReportController>()
                                                .repoartReason
                                                .value = 'Underage';
                                          },
                                          child: Container(
                                              width: 230,
                                              height: 50,
                                              decoration: Get.find<
                                                          ReportController>()
                                                      .option3
                                                      .value
                                                  ? BoxDecoration(
                                                      border: Border.all(
                                                        color: Color.fromRGBO(
                                                            255, 85, 115, 1),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)))
                                                  : BoxDecoration(),
                                              child: ReportOption(
                                                  option: 'Underage')),
                                        )),
                                    Obx(() => InkWell(
                                          onTap: () {
                                            Get.find<ReportController>()
                                                .option1
                                                .value = false;
                                            Get.find<ReportController>()
                                                .option2
                                                .value = false;
                                            Get.find<ReportController>()
                                                .option3
                                                .value = false;
                                            Get.find<ReportController>()
                                                .option4
                                                .value = true;
                                            Get.find<ReportController>()
                                                .option5
                                                .value = false;
                                            Get.find<ReportController>()
                                                .repoartReason
                                                .value = 'Not interested';
                                          },
                                          child: Container(
                                              width: 230,
                                              height: 50,
                                              decoration: Get.find<
                                                          ReportController>()
                                                      .option4
                                                      .value
                                                  ? BoxDecoration(
                                                      border: Border.all(
                                                        color: Color.fromRGBO(
                                                            255, 85, 115, 1),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)))
                                                  : BoxDecoration(),
                                              child: ReportOption(
                                                  option: 'Not interested')),
                                        )),
                                    Obx(() => InkWell(
                                          onTap: () {
                                            Get.find<ReportController>()
                                                .option1
                                                .value = false;
                                            Get.find<ReportController>()
                                                .option2
                                                .value = false;
                                            Get.find<ReportController>()
                                                .option3
                                                .value = false;
                                            Get.find<ReportController>()
                                                .option4
                                                .value = false;
                                            Get.find<ReportController>()
                                                .option5
                                                .value = true;
                                            Get.find<ReportController>()
                                                .repoartReason
                                                .value = 'Other';
                                          },
                                          child: Container(
                                              width: 230,
                                              height: 50,
                                              decoration: Get.find<
                                                          ReportController>()
                                                      .option5
                                                      .value
                                                  ? BoxDecoration(
                                                      border: Border.all(
                                                        color: Color.fromRGBO(
                                                            255, 85, 115, 1),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)))
                                                  : BoxDecoration(),
                                              child: ReportOption(
                                                  option: 'Other')),
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: 175,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (index + 1 ==
                                              feedScreenController
                                                  .usersList.length) {
                                            feedScreenController.endUser.value =
                                                true;
                                          }
                                          Get.back();
                                          Get.find<ReportController>()
                                              .option1
                                              .value = false;
                                          Get.find<ReportController>()
                                              .option2
                                              .value = false;
                                          Get.find<ReportController>()
                                              .option3
                                              .value = false;
                                          Get.find<ReportController>()
                                              .option4
                                              .value = false;
                                          Get.find<ReportController>()
                                              .option5
                                              .value = false;

                                          Get.find<FeedScreenController>()
                                              .currentIndex
                                              .value += 1;

                                          Get.find<FeedScreenController>()
                                              .scrollController
                                              .scrollToIndex(index + 1,
                                                  preferPosition:
                                                      AutoScrollPosition.end);
                                          Get.find<GlobalController>()
                                              .currentAppuser
                                              .value
                                              .excludedUsers!
                                              .add(currentUser.uid);

                                          DataBaseMethods().addExcludeUser(
                                              currentUser.uid!, true);

                                          DataBaseMethods().addReport(
                                              currentUser.uid!,
                                              Get.find<ReportController>()
                                                  .repoartReason
                                                  .value);
                                          Get.find<ReportController>()
                                              .repoartReason
                                              .value = '';
                                        },
                                        child: Text(
                                          'Report',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary:
                                                Color.fromRGBO(255, 85, 115, 1),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Report this profile',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(255, 85, 115, 1)),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          primary: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
