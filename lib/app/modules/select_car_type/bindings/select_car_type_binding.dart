import 'package:get/get.dart';

import '../controllers/select_car_type_controller.dart';

class SelectCarTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectCarTypeController>(
      () => SelectCarTypeController(),
    );
  }
}
