import 'package:get/get.dart';
import 'package:swapme/app/modules/cart/controllers/swap_controller.dart';

class SwapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SwapController>(
      () => SwapController(),
    );
  }
}
