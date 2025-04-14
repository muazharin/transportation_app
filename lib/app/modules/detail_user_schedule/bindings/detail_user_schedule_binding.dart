import 'package:get/get.dart';

import '../controllers/detail_user_schedule_controller.dart';

class DetailUserScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailUserScheduleController>(
      () => DetailUserScheduleController(),
    );
  }
}
