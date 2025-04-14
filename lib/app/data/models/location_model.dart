import 'package:latransportindo/app/data/models/customer_model.dart';

class LocationModel {
  String? id;
  String? name;
  String? address;
  CustomerModel? customer;
  String? status;

  LocationModel({
    this.id,
    this.name,
    this.address,
    this.customer,
    this.status,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        id: json["_id"],
        name: json["nama"],
        address: json["alamat"],
        customer: json["customer_id"] == null
            ? null
            : CustomerModel.fromJson(json["customer_id"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nama": name,
        "alamat": address,
        "customer_id": customer,
        "status": status,
      };
}
