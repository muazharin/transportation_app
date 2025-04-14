import 'package:get/get.dart';

import '../controllers/live_report_controller.dart';

class LiveReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveReportController>(
      () => LiveReportController(),
    );
  }
}
