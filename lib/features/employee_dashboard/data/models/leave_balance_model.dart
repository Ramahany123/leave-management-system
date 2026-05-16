class LeaveBalanceModel {
  final String typeName;
  final int total;
  final int taken;
  final int remaining;

  LeaveBalanceModel({
    required this.typeName,
    required this.total,
    required this.taken,
    required this.remaining,
  });

  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) =>
      LeaveBalanceModel(
        typeName: json["type_name"] as String,
        total: json["total"] as int,
        taken: json["taken"] as int,
        remaining: json["remaining"] as int,
      );
}
