import 'cubit/leave_request_form_fields.dart';

//TODO: localize text
class LeaveRequestValidator {
  /// Validates the leave request form inputs against Egyptian Labor Law and business rules.
  /// Returns a user-friendly English error message if validation fails, or `null` if valid.
  static String? validate(LeaveRequestFormFields fields) {
    // 1. Mandatory Fields Check
    if (fields.selectedLeaveType == null) {
      return "Please select a leave type.";
    }
    if (fields.startDate == null || fields.endDate == null) {
      return "Please select both start and end dates.";
    }
    if (fields.reason.trim().isEmpty) {
      return "Please enter the reason for your leave request.";
    }

    // 2. Date Order Validation
    if (fields.endDate!.isBefore(fields.startDate!)) {
      return "End date must be after or equal to start date.";
    }

    // 3. Retroactive Request Check (30 days maximum in the past)
    final today = DateTime.now();
    final difference = today.difference(fields.startDate!).inDays;
    if (difference > 30) {
      return "Start date cannot be more than 30 days in the past.";
    }

    // 4. Egyptian Fiscal Year Boundary Crossing (June 30 / July 1)
    final startYear = fields.startDate!.year;
    final june30 = DateTime(startYear, 6, 30);
    final july1 = DateTime(startYear, 7, 1);

    // Checks if the range starts on/before June 30 AND ends on/after July 1
    if (fields.startDate!.isBefore(july1) && fields.endDate!.isAfter(june30)) {
      return "Leave request cannot cross the fiscal year boundary (June 30 / July 1). Please split it into two separate requests.";
    }

    // Calculate requested duration (inclusive)
    final duration = fields.endDate!.difference(fields.startDate!).inDays + 1;

    // 5. Duration Minimum Check
    if (duration < fields.selectedLeaveType!.minDaysDuration) {
      return "Selected duration is too short. Minimum required is ${fields.selectedLeaveType!.minDaysDuration} day(s).";
    }

    // 6. Duration Maximum Check
    if (fields.selectedLeaveType!.maxDaysPerRequest != null &&
        duration > fields.selectedLeaveType!.maxDaysPerRequest!) {
      return "Selected duration exceeds the limit. Maximum allowed is ${fields.selectedLeaveType!.maxDaysPerRequest} day(s) per request.";
    }

    // 7. Delegate Selection Check
    if (fields.selectedLeaveType!.requiresDelegate &&
        fields.selectedDelegate == null) {
      return "This leave type requires selecting a delegate colleague.";
    }

    // 8. Mandatory Documents Check
    if (fields.selectedLeaveType!.requiresDocument) {
      for (final doc in fields.selectedLeaveType!.requiredDocuments) {
        if (doc.isMandatory &&
            !fields.selectedFiles.containsKey(doc.documentRequirementId)) {
          return "Please upload the required document: ${doc.documentName}.";
        }
      }
    }

    if (!fields.preLeaveAcknowledgement) {
      return "You must accept the legal undertaking to submit.";
    }

    return null; // All checks passed, the form is valid!
  }
}
