class MyScheduleModel {
  String? id;
  String? from;
  String? destination;
  String? status;

  MyScheduleModel({
    this.id,
    this.from,
    this.destination,
    this.status,
  });

  factory MyScheduleModel.fromJson(Map<String, dynamic> json) =>
      MyScheduleModel(
        id: json["id"],
        from: json["dari"],
        destination: json["ke"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dari": from,
        "ke": destination,
        "status": status,
      };
}
