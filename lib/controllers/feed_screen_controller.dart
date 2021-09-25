import 'package:chat/controllers/global_controller.dart';
import 'package:chat/helper/constants.dart';
import 'package:chat/helper/user_modal.dart';
import 'package:get/get.dart';

class FeedScreenController extends GetxController {
  final globalController = Get.put(GlobalController());
  final temp = 0.obs;
  final currentIndex = 0.obs;
  final potentialUsersList = <UserModel>[].obs;
  final userListLength = 0.obs;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
