import 'package:flutter/material.dart';
import 'package:latransportindo/app/data/models/customer_model.dart';
import 'package:latransportindo/app/data/models/form_location_model.dart';
import 'package:latransportindo/app/data/models/user_model.dart';
import 'package:latransportindo/app/data/models/vehicle_model.dart';

class FormScheduleModel {
  GlobalKey<FormState>? keyController;
  TextEditingController? idController;
  TextEditingController? driverController;
  TextEditingController? vehicleController;
  TextEditingController? customerController;
  UserModel? driverModel;
  VehicleModel? vehicleModel;
  CustomerModel? customerModel;
  List<FormLocationModel>? formLocationsModel;

  FormScheduleModel({
    this.keyController,
    this.idController,
    this.driverController,
    this.vehicleController,
    this.customerController,
    this.driverModel,
    this.vehicleModel,
    this.customerModel,
    this.formLocationsModel,
  });
}
