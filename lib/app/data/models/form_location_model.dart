import 'package:flutter/material.dart';
import 'package:latransportindo/app/data/models/location_model.dart';

class FormLocationModel {
  TextEditingController? locationController;
  LocationModel? locationsModel;

  FormLocationModel({
    this.locationController,
    this.locationsModel,
  });
}
