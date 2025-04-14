class DetailUserScheduleModel {
  String? idSchedule;
  DateTime? tanggalTugas;
  List<Location>? location;

  DetailUserScheduleModel({
    this.idSchedule,
    this.tanggalTugas,
    this.location,
  });

  factory DetailUserScheduleModel.fromJson(Map<String, dynamic> json) =>
      DetailUserScheduleModel(
        idSchedule: json["id_schedule"],
        tanggalTugas: json["tanggal_tugas"] == null
            ? null
            : DateTime.parse(json["tanggal_tugas"]),
        location: json["location"] == null
            ? []
            : List<Location>.from(
                json["location"]!.map((x) => Location.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_schedule": idSchedule,
        "tanggal_tugas": tanggalTugas?.toIso8601String(),
        "location": location == null
            ? []
            : List<dynamic>.from(location!.map((x) => x.toJson())),
      };
}

class Location {
  String? idLocation;
  String? nama;
  dynamic jam;
  dynamic statusLoading;

  Location({
    this.idLocation,
    this.nama,
    this.jam,
    this.statusLoading,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        idLocation: json["id_location"],
        nama: json["nama"],
        jam: json["jam"],
        statusLoading: json["status_loading"],
      );

  Map<String, dynamic> toJson() => {
        "id_location": idLocation,
        "nama": nama,
        "jam": jam,
        "status_loading": statusLoading,
      };
}
