import 'package:get/get.dart';

import '../controllers/select_driver_controller.dart';

class SelectDriverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectDriverController>(
      () => SelectDriverController(),
    );
  }
}
