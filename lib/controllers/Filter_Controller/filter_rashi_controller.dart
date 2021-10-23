import 'package:get/get.dart';

class FilterController extends GetxController {
  final reply = ''.obs;
  final filterSamajList = <String>[].obs;
  changeCommunity(String val) {
    reply.value = val;
  }
  
}
