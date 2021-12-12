import 'package:chat/controllers/feed_screen_controller.dart';
import 'package:chat/controllers/global_controller.dart';
import 'package:chat/controllers/subscription_controller.dart';
import 'package:chat/screens/buy_bookay_screen.dart';
import 'package:chat/screens/buy_message_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final subscriptionController = Get.put(SubscriptionController());

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController _refreshController2 =
      RefreshController(initialRefresh: false);

  final globalController = Get.put(GlobalController());

  ///Message plan updation
  void _onRefresh() async {
    // monitor network fetch
    await FirebaseFirestore.instance
        .collection("users")
        .doc(globalController.currentAppuser.value.uid)
        .get()
        .then((val) {
      Map<String, dynamic> tmpMap = val.data()!;
      Get.find<FeedScreenController>().messageOpenTill.value =
          tmpMap['messageOpenTill'];
      print(Get.find<FeedScreenController>().messageOpenTill.value);
    });
    print("This is buy message refresh");
    setState(() {
      
    });
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    print("This is buy message loading");

    _refreshController.loadComplete();
  }

  ///Bookay Plan Updation
  void _onRefresh2() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(globalController.currentAppuser.value.uid)
        .get()
        .then((val) {
      Map<String, dynamic> tmpMap = val.data()!;
      Get.find<GlobalController>().currentAppuser.value.bookayAvailable =
          tmpMap['bookayAvailable'];
      print(Get.find<GlobalController>().currentAppuser.value.bookayAvailable);
    });
    print("This is buy bookay refresh");
    // Get.off(SubscriptionScreen());
    setState(() {
      
    });
    _refreshController2.refreshCompleted();
  }

  void _onLoading2() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    print("______________________");
    print("This is buy bookay loading");
    _refreshController2.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: () => Get.back()),
          backgroundColor: Colors.white,
          title: Text(
            'Subscription',
            style: TextStyle(color: Colors.black, fontSize: 22),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelPadding: EdgeInsets.all(0),
            indicatorPadding: EdgeInsets.all(0),
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            labelStyle: TextStyle(fontSize: 18),
            indicatorColor: Color.fromRGBO(255, 85, 115, 1),
            tabs: [
              Tab(
                child: Text('Messaging'),
              ),
              Tab(
                child: Text('Bouquets'),
              ),
            ],
          ),
        ),
        body: Obx(() => subscriptionController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : TabBarView(
                children: [
                  SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: false,
                      controller: _refreshController,
                      header: MaterialClassicHeader(),
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      child: BuyMessageScreen(),
                      // footer: CustomFooter(
                      //     builder: (BuildContext context, LoadStatus? mode) {
                      //   Widget body;
                      //   if (mode == LoadStatus.loading) {
                      //     body = CupertinoActivityIndicator();
                      //   } else {
                      //     body = Container();
                      //   }
                      //   return Container(
                      //     height: 55.0,
                      //     child: Center(child: body),
                      //   );
                      // })
                      ),
                  SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: false,
                      
                      controller: _refreshController2,
                      header: MaterialClassicHeader(),
                      child: BuyBookayScreen(),
                      onRefresh: _onRefresh2,
                      onLoading: _onLoading2,
                      // footer: Container(),
                      // footer: CustomFooter(
                      //     builder: (BuildContext context, LoadStatus? mode) {
                      //   Widget body;
                      //   if (mode == LoadStatus.loading) {
                      //     body = CupertinoActivityIndicator();
                      //   } else {
                      //     body = Container();
                      //   }
                      //   return Container(
                      //     height: 55.0,
                      //     child: Center(child: body),
                      //   );
                      // })
                      ),
                ],
              )),
      ),
    );
  }
}
