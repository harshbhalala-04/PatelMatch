import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/widgets/info_title.dart';
import 'package:chat/widgets/user_image_card.dart';
import 'package:chat/widgets/user_info_card.dart';
import 'package:flutter/material.dart';

class SingleUserFeed extends StatelessWidget {
  final currentUserData;
  final userImagesLength;
  SingleUserFeed(
      {required this.currentUserData, required this.userImagesLength});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height,
      width: screenSize.width,
      child: Card(
        child: SingleChildScrollView(
          //controller: scrollController,
          child: Column(
            children: [
              CachedNetworkImage(
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                height: screenSize.height,
                width: screenSize.width,
                fit: BoxFit.cover,
                imageUrl: currentUserData.imageUrl,
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
                      '${currentUserData.name}, ${currentUserData.age}',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Personal Information',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
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
                    UserInfoCard(
                        title: 'Height', subTitle: currentUserData.height),
                    currentUserData.height != ' '
                        ? SizedBox(width: 20)
                        : SizedBox(
                            width: 0,
                          ),
                    UserInfoCard(
                        title: 'Community', subTitle: currentUserData.community)
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
                        title: 'Gender', subTitle: currentUserData.userGender),
                    currentUserData.userGender != ' '
                        ? SizedBox(width: 20)
                        : SizedBox(
                            width: 0,
                          ),
                    UserInfoCard(
                        title: 'Workout', subTitle: currentUserData.workout),
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
                  : UserImageCard(image: currentUserData.imageUrls[1]),
              currentUserData.education != ' ' ||
                      currentUserData.worklife != ' ' ||
                      currentUserData.salary != ' '
                  ? InfoTitle(title: 'Professional Information')
                  : Container(
                      height: 0,
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    UserInfoCard(
                        title: 'Education',
                        subTitle: currentUserData.education),
                    currentUserData.education != ' '
                        ? SizedBox(width: 20)
                        : SizedBox(
                            width: 0,
                          ),
                    UserInfoCard(
                        title: 'Worklife', subTitle: currentUserData.worklife),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: UserInfoCard(
                    title: 'Salary', subTitle: currentUserData.salary),
              ),
              SizedBox(
                height: 30,
              ),
             userImagesLength < 3
                  ? Container(
                      height: 0,
                    )
                  : UserImageCard(image: currentUserData.imageUrls[2]),
              currentUserData.drink != ' ' || currentUserData.smoke != ' '
                  ? InfoTitle(title: 'Social Life')
                  : Container(
                      height: 0,
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    UserInfoCard(
                        title: 'Drink', subTitle: currentUserData.drink),
                    currentUserData.drink != ' '
                        ? SizedBox(width: 20)
                        : SizedBox(
                            width: 0,
                          ),
                    UserInfoCard(
                        title: 'Smoke', subTitle: currentUserData.smoke)
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
                  : UserImageCard(image: currentUserData.imageUrls[3]),
              currentUserData.zodiacSign != ' ' ||
                      currentUserData.politics != ' ' ||
                      currentUserData.movies != ' '
                  ? InfoTitle(title: 'Others')
                  : Container(
                      height: 0,
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    UserInfoCard(
                        title: 'Zodiac Sign',
                        subTitle: currentUserData.zodiacSign),
                    currentUserData.zodiacSign != ' '
                        ? SizedBox(width: 20)
                        : SizedBox(
                            width: 0,
                          ),
                    UserInfoCard(
                        title: 'Political inclination',
                        subTitle: currentUserData.politics)
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: UserInfoCard(
                      title: 'Movies', subTitle: currentUserData.movies)),
              SizedBox(
                height: 30,
              ),
              userImagesLength < 5
                  ? Container(
                      height: 0,
                    )
                  : UserImageCard(image: currentUserData.imageUrls[4]),
              SizedBox(
                height: 20,
              ),
              userImagesLength < 6
                  ? Container(
                      height: 0,
                    )
                  : UserImageCard(image: currentUserData.imageUrls[5]),
              SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }
}
