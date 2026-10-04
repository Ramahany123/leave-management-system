import 'package:leave_management_system/features/admin_leave_configuration/data/models/leave_type_model.dart';
import 'package:leave_management_system/features/admin_leave_configuration/data/models/required_document_model.dart';
import 'package:leave_management_system/features/admin_leave_configuration/data/models/update_leave_type_field_enum.dart';

class UpdateLeaveTypeRequestModel {
  final String? typeName;
  final String? category;
  final String? balanceType;
  final num? fixedBalance;
  final bool? isPaid;
  final bool? deductFromBalance;
  final int? lifetimeLimit;
  final int? yearsOfServiceRequired;
  final int? minDaysDuration;
  final int? requiredGapDays;
  final int? maxDaysPerRequest;
  final String? description;
  final bool? requiresDocument;
  final bool? requiresDelegate;
  final String? genderPolicy;
  final String? calculationMethod;
  final List<RequiredDocument>? requiredDocuments;
  final Set<UpdateLeaveTypeField> _fieldsToUpdate;

  UpdateLeaveTypeRequestModel._({
    this.typeName,
    this.category,
    this.balanceType,
    this.fixedBalance,
    this.isPaid,
    this.deductFromBalance,
    this.lifetimeLimit,
    this.yearsOfServiceRequired,
    this.minDaysDuration,
    this.requiredGapDays,
    this.maxDaysPerRequest,
    this.description,
    this.requiresDocument,
    this.requiresDelegate,
    this.genderPolicy,
    this.calculationMethod,
    Set<UpdateLeaveTypeField> fieldsToUpdate = const {},
    this.requiredDocuments,
  }) : _fieldsToUpdate = Set<UpdateLeaveTypeField>.unmodifiable(fieldsToUpdate);
  bool get hasChanges => _fieldsToUpdate.isNotEmpty;
  factory UpdateLeaveTypeRequestModel.fromChanges({
    required LeaveType original,
    required String currentTypeName,
    required String? currentCategory,
    required String currentBalanceType,
    required num currentFixedBalance,
    required bool currentIsPaid,
    required bool currentDeductFromBalance,
    required int? currentLifetimeLimit,
    required int currentYearsOfServiceRequired,
    required int currentMinDaysDuration,
    required int currentRequiredGapDays,
    required int? currentMaxDaysPerRequest,
    required String? currentDescription,
    required bool currentRequiresDocument,
    required bool currentRequiresDelegate,
    required String currentGenderPolicy,
    required String currentCalculationMethod,
    required List<RequiredDocument> currentRequiredDocuments,
  }) {
    final fieldsToUpdate = <UpdateLeaveTypeField>{};

    String? typeName;
    String? category;
    String? balanceType;
    num? fixedBalance;
    bool? isPaid;
    bool? deductFromBalance;
    int? lifetimeLimit;
    int? yearsOfServiceRequired;
    int? minDaysDuration;
    int? requiredGapDays;
    int? maxDaysPerRequest;
    String? description;
    bool? requiresDocument;
    bool? requiresDelegate;
    String? genderPolicy;
    String? calculationMethod;
    List<RequiredDocument>? requiredDocuments;

    if (original.typeName != currentTypeName) {
      typeName = currentTypeName;
      fieldsToUpdate.add(UpdateLeaveTypeField.typeName);
    }

    if (original.category != currentCategory) {
      category = currentCategory;
      fieldsToUpdate.add(UpdateLeaveTypeField.category);
    }

    if (original.balanceType != currentBalanceType) {
      balanceType = currentBalanceType;
      fieldsToUpdate.add(UpdateLeaveTypeField.balanceType);
    }

    if (original.fixedBalance != currentFixedBalance) {
      fixedBalance = currentFixedBalance;
      fieldsToUpdate.add(UpdateLeaveTypeField.fixedBalance);
    }

    if (original.isPaid != currentIsPaid) {
      isPaid = currentIsPaid;
      fieldsToUpdate.add(UpdateLeaveTypeField.isPaid);
    }

    if (original.deductFromBalance != currentDeductFromBalance) {
      deductFromBalance = currentDeductFromBalance;
      fieldsToUpdate.add(UpdateLeaveTypeField.deductFromBalance);
    }

    if (original.lifetimeLimit != currentLifetimeLimit) {
      lifetimeLimit = currentLifetimeLimit;
      fieldsToUpdate.add(UpdateLeaveTypeField.lifetimeLimit);
    }

    if (original.yearsOfServiceRequired != currentYearsOfServiceRequired) {
      yearsOfServiceRequired = currentYearsOfServiceRequired;
      fieldsToUpdate.add(UpdateLeaveTypeField.yearsOfServiceRequired);
    }

    if (original.minDaysDuration != currentMinDaysDuration) {
      minDaysDuration = currentMinDaysDuration;
      fieldsToUpdate.add(UpdateLeaveTypeField.minDaysDuration);
    }

    if (original.requiredGapDays != currentRequiredGapDays) {
      requiredGapDays = currentRequiredGapDays;
      fieldsToUpdate.add(UpdateLeaveTypeField.requiredGapDays);
    }

    if (original.maxDaysPerRequest != currentMaxDaysPerRequest) {
      maxDaysPerRequest = currentMaxDaysPerRequest;
      fieldsToUpdate.add(UpdateLeaveTypeField.maxDaysPerRequest);
    }

    if (original.description != currentDescription) {
      description = currentDescription;
      fieldsToUpdate.add(UpdateLeaveTypeField.description);
    }

    if (original.requiresDocument != currentRequiresDocument) {
      requiresDocument = currentRequiresDocument;
      fieldsToUpdate.add(UpdateLeaveTypeField.requiresDocument);
    }

    if (original.requiresDelegate != currentRequiresDelegate) {
      requiresDelegate = currentRequiresDelegate;
      fieldsToUpdate.add(UpdateLeaveTypeField.requiresDelegate);
    }

    if (original.genderPolicy != currentGenderPolicy) {
      genderPolicy = currentGenderPolicy;
      fieldsToUpdate.add(UpdateLeaveTypeField.genderPolicy);
    }

    if (original.calculationMethod != currentCalculationMethod) {
      calculationMethod = currentCalculationMethod;
      fieldsToUpdate.add(UpdateLeaveTypeField.calculationMethod);
    }

    if (_requiredDocumentsChanged(
      original.requiredDocuments,
      currentRequiredDocuments,
    )) {
      requiredDocuments = currentRequiredDocuments;
      fieldsToUpdate.add(UpdateLeaveTypeField.requiredDocuments);
    }

    return UpdateLeaveTypeRequestModel._(
      fieldsToUpdate: fieldsToUpdate,
      typeName: typeName,
      category: category,
      balanceType: balanceType,
      fixedBalance: fixedBalance,
      isPaid: isPaid,
      deductFromBalance: deductFromBalance,
      lifetimeLimit: lifetimeLimit,
      yearsOfServiceRequired: yearsOfServiceRequired,
      minDaysDuration: minDaysDuration,
      requiredGapDays: requiredGapDays,
      maxDaysPerRequest: maxDaysPerRequest,
      description: description,
      requiresDocument: requiresDocument,
      requiresDelegate: requiresDelegate,
      genderPolicy: genderPolicy,
      calculationMethod: calculationMethod,
      requiredDocuments: requiredDocuments,
    );
  }

  Map<String, dynamic> toJson() {
    final values = <UpdateLeaveTypeField, Object?>{
      UpdateLeaveTypeField.typeName: typeName,
      UpdateLeaveTypeField.category: category,
      UpdateLeaveTypeField.balanceType: balanceType,
      UpdateLeaveTypeField.fixedBalance: fixedBalance,
      UpdateLeaveTypeField.isPaid: isPaid,
      UpdateLeaveTypeField.deductFromBalance: deductFromBalance,
      UpdateLeaveTypeField.lifetimeLimit: lifetimeLimit,
      UpdateLeaveTypeField.yearsOfServiceRequired: yearsOfServiceRequired,
      UpdateLeaveTypeField.minDaysDuration: minDaysDuration,
      UpdateLeaveTypeField.requiredGapDays: requiredGapDays,
      UpdateLeaveTypeField.maxDaysPerRequest: maxDaysPerRequest,
      UpdateLeaveTypeField.description: description,
      UpdateLeaveTypeField.requiresDocument: requiresDocument,
      UpdateLeaveTypeField.requiresDelegate: requiresDelegate,
      UpdateLeaveTypeField.genderPolicy: genderPolicy,
      UpdateLeaveTypeField.calculationMethod: calculationMethod,
      UpdateLeaveTypeField.requiredDocuments: requiredDocuments
          ?.map((document) => document.toJson())
          .toList(),
    };

    return {for (final field in _fieldsToUpdate) field.apiKey: values[field]};
  }

  static bool _requiredDocumentsChanged(
    List<RequiredDocument> original,
    List<RequiredDocument> current,
  ) {
    if (original.length != current.length) return true;
    for (final currentDocument in current) {
      if (currentDocument.documentRequirementId == null) return true;
      final originalDocument = original.cast<RequiredDocument?>().firstWhere(
        (document) =>
            document?.documentRequirementId ==
            currentDocument.documentRequirementId,
        orElse: () => null,
      );
      if (originalDocument == null) return true;
      if (originalDocument.isMandatory != currentDocument.isMandatory ||
          originalDocument.documentName != currentDocument.documentName) {
        return true;
      }
    }

    return false;
  }
}
