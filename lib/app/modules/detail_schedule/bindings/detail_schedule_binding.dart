import 'package:get/get.dart';

import '../controllers/detail_schedule_controller.dart';

class DetailScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailScheduleController>(
      () => DetailScheduleController(),
    );
  }
}
