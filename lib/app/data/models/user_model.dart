class UserModel {
  String? id;
  String? name;
  String? phone;
  String? password;
  String? userType;
  String? simNumber;

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.password,
    this.userType,
    this.simNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["nama"],
        phone: json["nomor_telepon"],
        password: json["password"] ?? "",
        userType: json["user_type"],
        simNumber: json["nomor_sim"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nama": name,
        "nomor_telepon": phone,
        "password": password,
        "user_type": userType,
        "nomor_sim": simNumber,
      };
}
