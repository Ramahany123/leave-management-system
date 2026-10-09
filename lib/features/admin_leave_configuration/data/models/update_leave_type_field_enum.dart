enum UpdateLeaveTypeField {
  typeName('type_name'),
  category('category'),
  balanceType('balance_type'),
  fixedBalance('fixed_balance'),
  isPaid('is_paid'),
  deductFromBalance('deduct_from_balance'),
  lifetimeLimit('lifetime_limit'),
  yearsOfServiceRequired('years_of_service_required'),
  minDaysDuration('min_days_duration'),
  requiredGapDays('required_gap_days'),
  maxDaysPerRequest('max_days_per_request'),
  description('description'),
  requiresDocument('requires_document'),
  requiresDelegate('requires_delegate'),
  genderPolicy('gender_policy'),
  calculationMethod('calculation_method'),
  requiredDocuments('required_documents');

  final String apiKey;

  const UpdateLeaveTypeField(this.apiKey);
}
