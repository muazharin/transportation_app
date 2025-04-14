class AuthModel {
  String? id;
  String? nama;
  String? userType;
  String? nomorTelepon;
  dynamic simNumber;
  bool? isNew;
  int? iat;
  int? exp;

  AuthModel({
    this.id,
    this.nama,
    this.userType,
    this.nomorTelepon,
    this.simNumber,
    this.isNew,
    this.iat,
    this.exp,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        id: json["_id"],
        nama: json["nama"],
        userType: json["user_type"],
        nomorTelepon: json["nomor_telepon"],
        simNumber: json["sim_number"],
        isNew: json["is_new"],
        iat: json["iat"],
        exp: json["exp"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nama": nama,
        "user_type": userType,
        "nomor_telepon": nomorTelepon,
        "sim_number": simNumber,
        "is_new": isNew,
        "iat": iat,
        "exp": exp,
      };
}
