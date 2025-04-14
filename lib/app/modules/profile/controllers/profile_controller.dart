import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:latransportindo/app/data/models/auth_model.dart';
import 'package:latransportindo/app/data/widgets/pop_up_logout.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  var box = GetStorage();
  var authModel = AuthModel();

  @override
  void onInit() {
    var token = box.read("token");
    authModel = AuthModel.fromJson(JwtDecoder.decode(token.toString()));
    super.onInit();
  }

  void logout() {
    Get.dialog(PopUpLogout(
      title: "Keluar?",
      detail: "Apakah kamu yakin ingin keluar dari aplikasi?",
      onTap: () => doLogout(),
    ));
  }

  void doLogout() {
    box.remove("is_login");
    box.remove("token");
    Get.offAllNamed(Routes.SIGNIN);
    // Get.dialog(const PopUpLogout(
    //   title: "Logout",
    //   isShowButton: false,
    //   detail:
    //       "Anda telah keluar dari\nsistem. Silahkan masuk kembali untuk\nmengakses semua fitur",
    // ));
  }
}
