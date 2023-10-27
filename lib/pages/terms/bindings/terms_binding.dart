import 'package:get/get.dart';
import '../controllers/terms_controller.dart';

class TermsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermsController>(
      () => TermsController(),
    );
  }
}
