import 'package:latransportindo/app/data/models/car_type_model.dart';

class VehicleModel {
  String? id;
  String? policeNumber;
  CarTypeModel? carType;
  String? note;
  String? doorNumber;
  String? kir;
  String? stnk;
  String? status;

  VehicleModel({
    this.id,
    this.policeNumber,
    this.carType,
    this.note,
    this.doorNumber,
    this.kir,
    this.stnk,
    this.status,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
        id: json["_id"],
        policeNumber: json["nomor_polisi"],
        carType: json["vehicle_type"] == null
            ? null
            : CarTypeModel.fromJson(json["vehicle_type"]),
        note: json["keterangan"],
        doorNumber: json["nomor_pintu"],
        kir: json["nomor_kir"],
        stnk: json["nomor_stnk"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nomor_polisi": policeNumber,
        "vehicle_type": carType,
        "keterangan": note,
        "nomor_pintu": doorNumber,
        "nomor_kir": kir,
        "nomor_stnk": stnk,
        "status": status,
      };
}
