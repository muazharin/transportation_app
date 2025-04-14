import 'package:get/get.dart';

import '../modules/add_customer/bindings/add_customer_binding.dart';
import '../modules/add_customer/views/add_customer_view.dart';
import '../modules/add_location/bindings/add_location_binding.dart';
import '../modules/add_location/views/add_location_view.dart';
import '../modules/add_schedule/bindings/add_schedule_binding.dart';
import '../modules/add_schedule/views/add_schedule_view.dart';
import '../modules/add_user/bindings/add_user_binding.dart';
import '../modules/add_user/views/add_user_view.dart';
import '../modules/add_vehicle/bindings/add_vehicle_binding.dart';
import '../modules/add_vehicle/views/add_vehicle_view.dart';
import '../modules/admin_home/bindings/admin_home_binding.dart';
import '../modules/admin_home/views/admin_home_view.dart';
import '../modules/create_new_password/bindings/create_new_password_binding.dart';
import '../modules/create_new_password/views/create_new_password_view.dart';
import '../modules/customers/bindings/customers_binding.dart';
import '../modules/customers/views/customers_view.dart';
import '../modules/detail_schedule/bindings/detail_schedule_binding.dart';
import '../modules/detail_schedule/views/detail_schedule_view.dart';
import '../modules/detail_user_schedule/bindings/detail_user_schedule_binding.dart';
import '../modules/detail_user_schedule/views/detail_user_schedule_view.dart';
import '../modules/live_report/bindings/live_report_binding.dart';
import '../modules/live_report/views/live_report_view.dart';
import '../modules/locations/bindings/locations_binding.dart';
import '../modules/locations/views/locations_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/schedule/bindings/schedule_binding.dart';
import '../modules/schedule/views/schedule_view.dart';
import '../modules/select_car_type/bindings/select_car_type_binding.dart';
import '../modules/select_car_type/views/select_car_type_view.dart';
import '../modules/select_customer/bindings/select_customer_binding.dart';
import '../modules/select_customer/views/select_customer_view.dart';
import '../modules/select_driver/bindings/select_driver_binding.dart';
import '../modules/select_driver/views/select_driver_view.dart';
import '../modules/select_location/bindings/select_location_binding.dart';
import '../modules/select_location/views/select_location_view.dart';
import '../modules/select_vehicle/bindings/select_vehicle_binding.dart';
import '../modules/select_vehicle/views/select_vehicle_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/user_history/bindings/user_history_binding.dart';
import '../modules/user_history/views/user_history_view.dart';
import '../modules/user_home/bindings/user_home_binding.dart';
import '../modules/user_home/views/user_home_view.dart';
import '../modules/user_schedule/bindings/user_schedule_binding.dart';
import '../modules/user_schedule/views/user_schedule_view.dart';
import '../modules/users/bindings/users_binding.dart';
import '../modules/users/views/users_view.dart';
import '../modules/vehicles/bindings/vehicles_binding.dart';
import '../modules/vehicles/views/vehicles_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => const SigninView(),
      binding: SigninBinding(),
      transitionDuration: const Duration(milliseconds: 1500),
    ),
    GetPage(
      name: _Paths.CREATE_NEW_PASSWORD,
      page: () => const CreateNewPasswordView(),
      binding: CreateNewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_HOME,
      page: () => const AdminHomeView(),
      binding: AdminHomeBinding(),
      transitionDuration: const Duration(milliseconds: 1500),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SCHEDULE,
      page: () => const ScheduleView(),
      binding: ScheduleBinding(),
    ),
    GetPage(
      name: _Paths.USERS,
      page: () => const UsersView(),
      binding: UsersBinding(),
    ),
    GetPage(
      name: _Paths.VEHICLES,
      page: () => const VehiclesView(),
      binding: VehiclesBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMERS,
      page: () => const CustomersView(),
      binding: CustomersBinding(),
    ),
    GetPage(
      name: _Paths.LOCATIONS,
      page: () => const LocationsView(),
      binding: LocationsBinding(),
    ),
    GetPage(
      name: _Paths.LIVE_REPORT,
      page: () => const LiveReportView(),
      binding: LiveReportBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SCHEDULE,
      page: () => const AddScheduleView(),
      binding: AddScheduleBinding(),
    ),
    GetPage(
      name: _Paths.ADD_USER,
      page: () => const AddUserView(),
      binding: AddUserBinding(),
    ),
    GetPage(
      name: _Paths.ADD_VEHICLE,
      page: () => const AddVehicleView(),
      binding: AddVehicleBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CUSTOMER,
      page: () => const AddCustomerView(),
      binding: AddCustomerBinding(),
    ),
    GetPage(
      name: _Paths.ADD_LOCATION,
      page: () => const AddLocationView(),
      binding: AddLocationBinding(),
    ),
    GetPage(
      name: _Paths.USER_HOME,
      page: () => const UserHomeView(),
      binding: UserHomeBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_CAR_TYPE,
      page: () => const SelectCarTypeView(),
      binding: SelectCarTypeBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_CUSTOMER,
      page: () => const SelectCustomerView(),
      binding: SelectCustomerBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_DRIVER,
      page: () => const SelectDriverView(),
      binding: SelectDriverBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_LOCATION,
      page: () => const SelectLocationView(),
      binding: SelectLocationBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_VEHICLE,
      page: () => const SelectVehicleView(),
      binding: SelectVehicleBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_SCHEDULE,
      page: () => const DetailScheduleView(),
      binding: DetailScheduleBinding(),
    ),
    GetPage(
      name: _Paths.USER_SCHEDULE,
      page: () => const UserScheduleView(),
      binding: UserScheduleBinding(),
    ),
    GetPage(
      name: _Paths.USER_HISTORY,
      page: () => const UserHistoryView(),
      binding: UserHistoryBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_USER_SCHEDULE,
      page: () => const DetailUserScheduleView(),
      binding: DetailUserScheduleBinding(),
    ),
  ];
}
