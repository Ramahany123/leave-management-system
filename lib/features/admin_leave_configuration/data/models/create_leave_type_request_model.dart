import 'package:leave_management_system/features/admin_leave_configuration/data/models/required_document_model.dart';
import 'package:leave_management_system/features/admin_leave_configuration/data/models/work_flow_step_model.dart';

class CreateLeaveTypeRequestModel {
  final String typeName;
  final String? category;
  final String balanceType;
  final num? fixedBalance;
  final bool isPaid;
  final bool deductFromBalance;
  final int? lifetimeLimit;
  final int yearsOfServiceRequired;
  final int minDaysDuration;
  final int requiredGapDays;
  final int? maxDaysPerRequest;
  final String? description;
  final bool requiresDocument;
  final bool requiresDelegate;
  final String genderPolicy;
  final String calculationMethod;
  final List<WorkflowStep> workflow;
  final List<RequiredDocument> requiredDocuments;

  CreateLeaveTypeRequestModel({
    required this.typeName,
    required this.category,
    required this.balanceType,
    required this.fixedBalance,
    required this.isPaid,
    required this.deductFromBalance,
    required this.lifetimeLimit,
    required this.yearsOfServiceRequired,
    required this.minDaysDuration,
    required this.requiredGapDays,
    required this.maxDaysPerRequest,
    required this.description,
    required this.requiresDocument,
    required this.requiresDelegate,
    required this.genderPolicy,
    required this.calculationMethod,
    required this.workflow,
    required this.requiredDocuments,
  });

  Map<String, dynamic> toJson() {
    return {
      'type_name': typeName,
      'category': category,
      'balance_type': balanceType,
      'fixed_balance': fixedBalance,
      'is_paid': isPaid,
      'deduct_from_balance': deductFromBalance,
      'lifetime_limit': lifetimeLimit,
      'years_of_service_required': yearsOfServiceRequired,
      'min_days_duration': minDaysDuration,
      'required_gap_days': requiredGapDays,
      'max_days_per_request': maxDaysPerRequest,
      'description': description,
      'requires_document': requiresDocument,
      'requires_delegate': requiresDelegate,
      'gender_policy': genderPolicy,
      'calculation_method': calculationMethod,
      'workflow': workflow.map((e) => e.toJson()).toList(),
      'requiredDocuments': requiredDocuments.map((e) => e.toJson()).toList(),
    };
  }
}
