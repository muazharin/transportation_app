class CarTypeModel {
  String? id;
  String? name;

  CarTypeModel({
    this.id,
    this.name,
  });

  factory CarTypeModel.fromJson(Map<String, dynamic> json) => CarTypeModel(
        id: json["_id"],
        name: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nama": name,
      };
}
