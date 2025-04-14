class MonthModel {
  String? name;
  String? no;

  MonthModel({
    this.name,
    this.no,
  });

  factory MonthModel.fromJson(Map<String, dynamic> json) => MonthModel(
        name: json["name"],
        no: json["no"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "no": no,
      };
}
