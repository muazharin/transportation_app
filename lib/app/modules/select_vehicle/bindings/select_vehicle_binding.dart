import 'package:get/get.dart';

import '../controllers/select_vehicle_controller.dart';

class SelectVehicleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectVehicleController>(
      () => SelectVehicleController(),
    );
  }
}
