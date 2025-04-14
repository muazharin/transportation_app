import 'package:latransportindo/app/data/models/customer_model.dart';
import 'package:latransportindo/app/data/models/month_model.dart';
import 'package:latransportindo/app/data/models/user_model.dart';
import 'package:latransportindo/app/data/models/vehicle_model.dart';
import 'package:latransportindo/app/data/models/location_model.dart';

var isFirstLogin = true;
var isTroughtRoute = false;
var isAlternative = false;
var users = <UserModel>[];
var vehicles = <VehicleModel>[];
var customers = <CustomerModel>[];
var locations = <LocationModel>[];
var months = [
  MonthModel(name: 'Desember', no: "12"),
  MonthModel(name: 'November', no: "11"),
  MonthModel(name: 'Oktober', no: "10"),
  MonthModel(name: 'September', no: "09"),
  MonthModel(name: 'Agustus', no: "08"),
  MonthModel(name: 'Juli', no: "07"),
  MonthModel(name: 'Juni', no: "06"),
  MonthModel(name: 'Mei', no: "05"),
  MonthModel(name: 'April', no: "04"),
  MonthModel(name: 'Maret', no: "03"),
  MonthModel(name: 'Februari', no: "02"),
  MonthModel(name: 'Januari', no: "01"),
];
