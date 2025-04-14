class HistoryUserModel {
  String? id;
  String? namaLokasi;
  String? status;
  DateTime? tanggal;
  String? jam;
  String? nama;

  HistoryUserModel({
    this.id,
    this.namaLokasi,
    this.status,
    this.tanggal,
    this.jam,
    this.nama,
  });

  factory HistoryUserModel.fromJson(Map<String, dynamic> json) =>
      HistoryUserModel(
        id: json["_id"],
        namaLokasi: json["nama_lokasi"],
        status: json["status"],
        tanggal:
            json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        jam: json["jam"],
        nama: json["nama"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nama_lokasi": namaLokasi,
        "status": status,
        "tanggal":
            "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "jam": jam,
        "nama": nama,
      };
}
