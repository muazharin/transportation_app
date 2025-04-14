class ScheduleModel {
  String? id;
  bool? isChecked;
  DateTime? tanggalTugas;
  Datum? nama;
  List<Location>? location;
  Datum? vehicle;
  Datum? customer;

  ScheduleModel({
    this.id,
    this.isChecked,
    this.tanggalTugas,
    this.nama,
    this.location,
    this.vehicle,
    this.customer,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        id: json["_id"],
        isChecked: json["is_checked"] ?? false,
        tanggalTugas: json["tanggal_tugas"] == null
            ? null
            : DateTime.parse(json["tanggal_tugas"]),
        nama: json["nama"] == null ? null : Datum.fromJson(json["nama"]),
        location: json["location"] == null
            ? []
            : List<Location>.from(
                json["location"]!.map((x) => Location.fromJson(x))),
        vehicle:
            json["vehicle"] == null ? null : Datum.fromJson(json["vehicle"]),
        customer:
            json["customer"] == null ? null : Datum.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "is_checked": isChecked,
        "tanggal_tugas": tanggalTugas?.toIso8601String(),
        "nama": nama?.toJson(),
        "location": location == null
            ? []
            : List<dynamic>.from(location!.map((x) => x.toJson())),
        "vehicle": vehicle?.toJson(),
        "customer": customer?.toJson(),
      };
}

class Datum {
  String? id;
  String? nama;

  Datum({
    this.id,
    this.nama,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nama": nama,
      };
}

class Location {
  String? nama;
  dynamic jam;
  dynamic statusLoading;
  String? id;
  String? idLocation;

  Location({
    this.id,
    this.nama,
    this.idLocation,
    this.jam,
    this.statusLoading,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        nama: json["nama"],
        jam: json["jam"],
        statusLoading: json["status_loading"],
        id: json["_id"],
        idLocation: json["id_location"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "jam": jam,
        "status_loading": statusLoading,
        "_id": id,
        "id_location": idLocation,
      };
}
