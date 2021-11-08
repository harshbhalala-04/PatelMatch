import 'package:chat/controllers/subscription_controller.dart';
import 'package:chat/screens/buy_bookay_screen.dart';
import 'package:chat/screens/buy_message_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionScreen extends StatelessWidget {
  final subscriptionController = Get.put(SubscriptionController());

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
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelPadding: EdgeInsets.all(0),
            indicatorPadding: EdgeInsets.all(0),
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.white,
            labelStyle: TextStyle(fontSize: 16),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color.fromRGBO(255, 85, 115, 1),
            ),
            tabs: [
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color.fromRGBO(255, 85, 115, 0.3),
                  ),
                  child: Align(
                    child: Text('Messaging'),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color.fromRGBO(255, 85, 115, 0.3),
                  ),
                  child: Align(child: Text('Bouquets')),
                ),
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
                  BuyMessageScreen(),
                  BuyBookayScreen(),
                ],
              )),
      ),
    );
  }
}
