import 'package:get/get.dart';
import 'package:latransportindo/app/modules/user_history/controllers/user_history_controller.dart';
import 'package:latransportindo/app/modules/user_schedule/controllers/user_schedule_controller.dart';

import '../controllers/user_home_controller.dart';

class UserHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserHomeController>(() => UserHomeController());
    Get.put(UserScheduleController());
    Get.put(UserHistoryController());
  }
}
