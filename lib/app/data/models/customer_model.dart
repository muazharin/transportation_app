class CustomerModel {
  String? id;
  String? name;
  String? phoneNumber;
  String? email;
  String? status;

  CustomerModel({
    this.id,
    this.name,
    this.phoneNumber,
    this.email,
    this.status,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        id: json["_id"],
        name: json["nama"],
        phoneNumber: json["nomor_telepon"],
        email: json["email"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nama": name,
        "nomor_telepon": phoneNumber,
        "email": email,
        "status": status,
      };
}
