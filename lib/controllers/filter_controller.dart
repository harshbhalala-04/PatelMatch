import 'package:chat/controllers/global_controller.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  final reply = ''.obs;
  final filterSamajList = <String>{}.obs;
  final filterIncomeList = <String>{}.obs;
  final filterVerifiedList = <String>{}.obs;
  final filterHeightList = <String>{}.obs;
  final filterStarList = <String>{}.obs;
  final filterRashiList = <String>{}.obs;
  final filterDrinkList = <String>{}.obs;
  final filterSmokeList = <String>{}.obs;
  final filterNRIList = <String>{}.obs;
  final nriSubtitle = ''.obs;
  final samajSubtitle = ''.obs;
  final incomeSubtitle = ''.obs;
  final verifiedSubtitle = ''.obs;
  final heightSubtitle = ''.obs;
  final starSubtitle = ''.obs;
  final rashiSubtitle = ''.obs;
  final drinkSubtitle = ''.obs;
  final smokeSubtitle = ''.obs;
  final isLoading = false.obs;
 

  @override
  void onInit() {
    isLoading.toggle();
    List<dynamic> samajList =
        Get.find<GlobalController>().currentAppuser.value.filters!.samaj!;
    List<dynamic> incomeList =
        Get.find<GlobalController>().currentAppuser.value.filters!.incomeRange!;
    List<dynamic> verifiedList = Get.find<GlobalController>()
        .currentAppuser
        .value
        .filters!
        .verifiedOnly!;
    List<dynamic> heightList =
        Get.find<GlobalController>().currentAppuser.value.filters!.height!;
    List<dynamic> starList =
        Get.find<GlobalController>().currentAppuser.value.filters!.starSign!;
    List<dynamic> rashiList =
        Get.find<GlobalController>().currentAppuser.value.filters!.rashi!;
    List<dynamic> drinkList =
        Get.find<GlobalController>().currentAppuser.value.filters!.drink!;
    List<dynamic> smokeList =
        Get.find<GlobalController>().currentAppuser.value.filters!.smoke!;
    List<dynamic> nriList =
        Get.find<GlobalController>().currentAppuser.value.filters!.nri!;

    if (samajList.contains('Any')) {
      samajSubtitle.value = 'Any';
    } else {
      for (int i = 0; i < samajList.length; i++) {
        filterSamajList.add(samajList[i]);
        if (i == 0) {
          samajSubtitle.value = samajList[i];
        } else {
          samajSubtitle.value = samajSubtitle.value + ',' + samajList[i];
        }
      }
    }

    if (incomeList.contains('Any')) {
      incomeSubtitle.value = 'Any';
    } else {
      for (int i = 0; i < incomeList.length; i++) {
        filterIncomeList.add(incomeList[i]);
        if (i == 0) {
          incomeSubtitle.value = incomeList[i];
        } else {
          incomeSubtitle.value = incomeSubtitle.value + ',' + incomeList[i];
        }
      }
    }

    if (verifiedList.contains('Any')) {
      verifiedSubtitle.value = 'Any';
    } else {
      for (int i = 0; i < verifiedList.length; i++) {
        filterVerifiedList.add(verifiedList[i]);
        if (i == 0) {
          verifiedSubtitle.value = verifiedList[i];
        } else {
          verifiedSubtitle.value =
              verifiedSubtitle.value + ',' + verifiedList[i];
        }
      }
    }

    if (heightList.contains('Any')) {
      heightSubtitle.value = 'Any';
    } else {
      for (int i = 0; i < heightList.length; i++) {
        filterHeightList.add(heightList[i]);
        if (i == 0) {
          heightSubtitle.value = heightList[i];
        } else {
          heightSubtitle.value = heightSubtitle.value + ',' + heightList[i];
        }
      }
    }

    if (starList.contains('Any')) {
      starSubtitle.value = 'any';
    } else {
      for (int i = 0; i < starList.length; i++) {
        filterStarList.add(starList[i]);
        if (i == 0) {
          starSubtitle.value = starList[i];
        } else {
          starSubtitle.value = starSubtitle.value + ',' + starList[i];
        }
      }
    }

    if (rashiList.contains('Any')) {
      rashiSubtitle.value = 'any';
    } else {
      for (int i = 0; i < rashiList.length; i++) {
        filterRashiList.add(rashiList[i]);
        if (i == 0) {
          rashiSubtitle.value = rashiList[i];
        } else {
          rashiSubtitle.value = rashiSubtitle.value + ',' + rashiList[i];
        }
      }
    }

    if (drinkList.contains('Any')) {
      drinkSubtitle.value = 'Any';
    }
    for (int i = 0; i < drinkList.length; i++) {
      filterDrinkList.add(drinkList[i]);
      if (i == 0) {
        drinkSubtitle.value = drinkList[i];
      } else {
        drinkSubtitle.value = drinkSubtitle.value + ',' + drinkList[i];
      }
    }

    if (smokeList.contains('Any')) {
      smokeSubtitle.value = 'Any';
    } else {
      for (int i = 0; i < smokeList.length; i++) {
        filterSmokeList.add(smokeList[i]);
        if (i == 0) {
          smokeSubtitle.value = smokeList[i];
        } else {
          smokeSubtitle.value = smokeSubtitle.value + ',' + smokeList[i];
        }
      }
    }

    if (nriList.contains('Any')) {
      nriSubtitle.value = 'Any';
    } else {
      for (int i = 0; i < nriList.length; i++) {
        filterNRIList.add(nriList[i]);
        if (i == 0) {
          nriSubtitle.value = nriList[i];
        } else {
          nriSubtitle.value = nriSubtitle.value + ',' + nriList[i];
        }
      }
    }
    isLoading.toggle();
    super.onInit();
  }
}
