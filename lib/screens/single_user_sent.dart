import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SingleUserSent extends StatefulWidget {
  List<dynamic> sentProfiles;

  SingleUserSent({required this.sentProfiles});

  @override
  _SingleUserSentState createState() => _SingleUserSentState();
}

class _SingleUserSentState extends State<SingleUserSent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'Sent ',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Text('(' + widget.sentProfiles.length.toString() + ')',
                  style: TextStyle(
                    fontSize: 14,
                  )),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.sentProfiles.length,
            itemBuilder: (context, index) {
              print('This is list tile starting');
              print(widget.sentProfiles[index]['sent']);
              print(widget.sentProfiles[index]['image']);
              return InkWell(
                onTap: () {},
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                        widget.sentProfiles[index]['image']),
                    backgroundColor: Colors.grey,
                  ),
                  title: Text(widget.sentProfiles[index]['sent']),
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
