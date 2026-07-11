import '../../data/models/delegate_user_model.dart';
import '../../data/models/eligible_leave_type_model.dart';

class LeaveRequestFormFields {
  final EligibleLeaveTypeModel? selectedLeaveType;
  final DateTime? startDate;
  final DateTime? endDate;
  final String reason;
  final DelegateUserModel? selectedDelegate;
  final Map<int, String>
  selectedFiles; // Key: documentRequirementId, Value: filePath
  final bool preLeaveAcknowledgement;

  LeaveRequestFormFields({
    this.selectedLeaveType,
    this.startDate,
    this.endDate,
    this.reason = "",
    this.selectedDelegate,
    Map<int, String>? selectedFiles,
    this.preLeaveAcknowledgement = true,
  }) : selectedFiles = selectedFiles ?? const {};

  // copyWith allows us to create a copy of the fields with only specific values changed
  LeaveRequestFormFields copyWith({
    EligibleLeaveTypeModel? selectedLeaveType,
    DateTime? startDate,
    DateTime? endDate,
    String? reason,
    DelegateUserModel? selectedDelegate,
    Map<int, String>? selectedFiles,
    bool? preLeaveAcknowledgement,
  }) {
    return LeaveRequestFormFields(
      selectedLeaveType: selectedLeaveType ?? this.selectedLeaveType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      reason: reason ?? this.reason,
      selectedDelegate: selectedDelegate ?? this.selectedDelegate,
      selectedFiles: selectedFiles ?? this.selectedFiles,
      preLeaveAcknowledgement:
          preLeaveAcknowledgement ?? this.preLeaveAcknowledgement,
    );
  }
}
