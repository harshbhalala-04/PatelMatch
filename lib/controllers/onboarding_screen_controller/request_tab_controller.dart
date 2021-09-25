import 'package:get/get.dart';

class RequestTabController extends GetxController {
  final selectedPage = 0.obs;

  void changePage(int pageNum) {
    selectedPage.value = pageNum;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}