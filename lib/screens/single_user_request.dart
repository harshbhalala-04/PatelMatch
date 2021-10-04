import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SingleUserRequest extends StatelessWidget {
  List<dynamic> profiles;
  List<dynamic> specialProfiles;
  SingleUserRequest({
    required this.profiles,
    required this.specialProfiles,
  });
  @override
  Widget build(BuildContext context) {
    print('This is special Profiels list: ');
    print(specialProfiles.length);
    return Column(
      children: [
        specialProfiles.length != 0
            ? Row(
                children: [
                  Text(
                    'Special requests',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text('(' + specialProfiles.length.toString() + ')',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ],
              )
            : Container(),
        specialProfiles.length != 0 ? SizedBox(height: 10) : Container(),
        specialProfiles.length != 0
            ? Expanded(
                child: ListView.builder(
                  itemCount: specialProfiles.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              leading: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: CachedNetworkImageProvider(
                                      specialProfiles[index]['image'])),
                              title: Text(specialProfiles[index]['recieve'],
                                  style: TextStyle(fontSize: 18)),
                              subtitle: Row(
                                children: [
                                  Text(
                                    "${specialProfiles[index]['recieve']} has sent you",
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(specialProfiles[index]['bookay']
                                      .toString()),
                                  Transform.rotate(
                                    angle: 0.2,
                                    child: Image.asset(
                                      'assets/bokay.png',
                                      color: Colors.pink,
                                      width: 15,
                                      height: 20,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Icon(
                                Icons.arrow_right_rounded,
                                color: Color.fromRGBO(255, 85, 115, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : Container(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Text(
                'Pending ',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Text('(' + profiles.length.toString() + ')',
                  style: TextStyle(
                    fontSize: 18,
                  )),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        CachedNetworkImageProvider(profiles[index]['image']),
                    backgroundColor: Colors.grey,
                  ),
                  title: Text(profiles[index]['recieve']),
                  trailing: TextButton(
                      child: Text(
                        'View',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(255, 85, 115, 1)),
                      ),
                      onPressed: () {}),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
