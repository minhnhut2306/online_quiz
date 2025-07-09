import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxBool isLoading = true.obs;
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = false;
  }

  changePage(int index) {
    currentIndex.value = index;
  }
}
