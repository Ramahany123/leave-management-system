class LeaveRequestBodyModel {
  final int typeId;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final bool preLeaveAcknowledgement;
  final Map<int, String>? documentFiles;
  final int? delegateUserId;

  LeaveRequestBodyModel({
    required this.typeId,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.preLeaveAcknowledgement,
    this.documentFiles,
    this.delegateUserId,
  });
}
