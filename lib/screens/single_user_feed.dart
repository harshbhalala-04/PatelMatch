import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/helper/user_modal.dart';
import 'package:chat/widgets/info_title.dart';
import 'package:chat/widgets/user_image_card.dart';
import 'package:chat/widgets/user_info_card.dart';
import 'package:flutter/material.dart';

class SingleUserFeed extends StatelessWidget {
  final UserModel currentUser;
  final int userImagesLength;
  SingleUserFeed({required this.currentUser, required this.userImagesLength});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    print(userImagesLength);
    return Container(
      height: screenSize.height,
      width: screenSize.width,
      child: Card(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CachedNetworkImage(
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                height: screenSize.height,
                width: screenSize.width,
                fit: BoxFit.cover,
                imageUrl: currentUser.imgUrl!,
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
                    UserInfoCard(title: 'Height', subTitle: currentUser.height),
                    currentUser.height != null
                        ? SizedBox(width: 20)
                        : SizedBox(
                            width: 0,
                          ),
                    UserInfoCard(
                        title: 'Community', subTitle: currentUser.community)
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
                    UserInfoCard(title: 'Gender', subTitle: currentUser.gender),
                    currentUser.gender != null
                        ? SizedBox(width: 20)
                        : SizedBox(
                            width: 0,
                          ),
                    UserInfoCard(
                        title: 'Workout', subTitle: currentUser.workout),
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
              currentUser.education != null ||
                      currentUser.worklife != null ||
                      currentUser.salary != null
                  ? InfoTitle(title: 'Professional Information')
                  : Container(
                      height: 0,
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    UserInfoCard(
                        title: 'Education', subTitle: currentUser.education),
                    currentUser.education != null
                        ? SizedBox(width: 20)
                        : SizedBox(
                            width: 0,
                          ),
                    UserInfoCard(
                        title: 'Worklife', subTitle: currentUser.worklife),
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
                    UserInfoCard(title: 'Salary', subTitle: currentUser.salary),
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
              currentUser.drink != null || currentUser.smoke != null
                  ? InfoTitle(title: 'Social Life')
                  : Container(
                      height: 0,
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    UserInfoCard(title: 'Drink', subTitle: currentUser.drink),
                    currentUser.drink != null
                        ? SizedBox(width: 20)
                        : SizedBox(
                            width: 0,
                          ),
                    UserInfoCard(title: 'Smoke', subTitle: currentUser.smoke)
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
              currentUser.zodiacSign != null ||
                      currentUser.politics != null ||
                      currentUser.movie != null
                  ? InfoTitle(title: 'Others')
                  : Container(
                      height: 0,
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    UserInfoCard(
                        title: 'Zodiac Sign', subTitle: currentUser.zodiacSign),
                    currentUser.zodiacSign != null
                        ? SizedBox(width: 20)
                        : SizedBox(
                            width: 0,
                          ),
                    UserInfoCard(
                        title: 'Political inclination',
                        subTitle: currentUser.politics)
                  ],
                ),
              ),
             Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    UserInfoCard(title: 'Movies', subTitle: currentUser.movie),
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
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }
}
