import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
              return InkWell(
                onTap: () {},
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                        sentProfiles[index]['image']),
                    backgroundColor: Colors.grey,
                  ),
                  title: Row(
                    children: [
                      Text("${sentProfiles[index]['sent']}  ", style: TextStyle(color: Color.fromRGBO(51, 51, 51, 1),),),
                      sentProfiles[index]['bookay'] > 0
                          ? Text("${sentProfiles[index]['bookay'].toString()} ", style: TextStyle(color: Color.fromRGBO(51, 51, 51, 1),),)
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
