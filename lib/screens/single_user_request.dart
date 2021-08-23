import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SingleUserRequest extends StatefulWidget {
  List<dynamic> profiles;

  SingleUserRequest({required this.profiles});

  @override
  _SingleUserRequestState createState() => _SingleUserRequestState();
}

class _SingleUserRequestState extends State<SingleUserRequest> {
  @override
  Widget build(BuildContext context) {
    print('This is all profiles');
    print(widget.profiles);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'Pending ',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Text('(' + widget.profiles.length.toString() + ')',
                  style: TextStyle(
                    fontSize: 14,
                  )),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.profiles.length,
            itemBuilder: (context, index) {
              print('This is list tile starting');
              print(widget.profiles[index]['recieve']);
              print(widget.profiles[index]['image']);
              return InkWell(
                onTap: () {},
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                        widget.profiles[index]['image']),
                    backgroundColor: Colors.grey,
                  ),
                  title: Text(widget.profiles[index]['recieve']),
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
            // child: Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Column(
            //     children: [
            //       Row(
            //         children: [
            //           Text(
            //             'Special requests',
            //             style: TextStyle(
            //               fontSize: 18,
            //             ),
            //           ),
            //           SizedBox(
            //             width: 4,
            //           ),
            //           Text(
            //             '(2)',
            //             style: TextStyle(
            //               fontSize: 18,
            //             ),
            //           ),
            //         ],
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Container(
            //         child: Padding(
            //           padding: const EdgeInsets.all(6.0),
            //           child: Card(
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: ListTile(
            //               leading: CircleAvatar(
            //                 backgroundColor: Colors.grey,
            //                 // child: Image(
            //                 //   image: AssetImage('assets/virat.png'),
            //                 // ),
            //                 backgroundImage: CachedNetworkImageProvider(''),
            //               ),
            //               title: Text('Ana', style: TextStyle(fontSize: 18)),
            //               subtitle: Row(
            //                 children: [
            //                   Text('Ana has sent you'),
            //                   SizedBox(
            //                     width: 2,
            //                   ),
            //                   Image.asset(
            //                     'assets/bokay.png',
            //                     color: Colors.pink,
            //                     height: 20,
            //                   )
            //                 ],
            //               ),
            //               trailing: Icon(
            //                 Icons.arrow_right_rounded,
            //                 color: Color.fromRGBO(255, 85, 115, 1),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Container(
            //         child: Padding(
            //           padding: const EdgeInsets.all(6.0),
            //           child: Card(
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: ListTile(
            //               leading: CircleAvatar(
            //                 backgroundColor: Colors.grey,
            //                 child: Image(
            //                   image: AssetImage('assets/virat.png'),
            //                 ),
            //               ),
            //               title: Text('Abcd', style: TextStyle(fontSize: 18)),
            //               subtitle: Row(
            //                 children: [
            //                   Text('Abcd has sent you'),
            //                   SizedBox(
            //                     width: 2,
            //                   ),
            //                   Image.asset(
            //                     'assets/bokay.png',
            //                     color: Colors.pink,
            //                     height: 20,
            //                   ),
            //                 ],
            //               ),
            //               trailing: Icon(
            //                 Icons.arrow_right_rounded,
            //                 color: Color.fromRGBO(255, 85, 115, 1),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),
          ),
        ),
      ],
    );
  }
}
