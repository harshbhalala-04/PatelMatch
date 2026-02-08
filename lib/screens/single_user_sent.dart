import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'show_profile_screen.dart';

class SingleUserSent extends StatelessWidget {
  List<dynamic> sentProfiles;

  SingleUserSent({required this.sentProfiles});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  'Sent ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(51, 51, 51, 1),
                  ),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Text('(' + sentProfiles.length.toString() + ')',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(51, 51, 51, 1),
                  )),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: sentProfiles.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                      sentProfiles[index]['image']),
                  backgroundColor: Colors.grey,
                ),
                title: Row(
                  children: [
                    Text(
                      "${sentProfiles[index]['sent']}  ",
                      style: TextStyle(
                        color: Color.fromRGBO(51, 51, 51, 1),
                      ),
                    ),
                    sentProfiles[index]['bookay'] > 0
                        ? Text(
                            "${sentProfiles[index]['bookay'].toString()} ",
                            style: TextStyle(
                              color: Color.fromRGBO(51, 51, 51, 1),
                            ),
                          )
                        : Container(),
                    sentProfiles[index]['bookay'] > 0
                        ? Transform.rotate(
                            angle: 0.2,
                            child: Image.asset(
                              'assets/bokay.png',
                              color: Colors.pink,
                              width: 15,
                              height: 20,
                            ),
                          )
                        : Container(),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
