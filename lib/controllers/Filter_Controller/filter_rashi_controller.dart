import 'package:get/get.dart';

class FilterRashiController extends GetxController {
  final reply = ''.obs;

  changeCommunity(String val) {
    reply.value = val;
  }
}
