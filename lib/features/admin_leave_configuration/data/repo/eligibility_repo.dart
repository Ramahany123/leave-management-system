import 'package:leave_management_system/core/utils/handle_repository_call.dart';

import '../../../../core/utils/result.dart';
import '../models/create_eligibility_rule_request_model.dart';
import '../models/eligibility_rule_model.dart';
import '../web_services/eligibility_web_service.dart';

class EligibilityRepo {
  final EligibilityWebService _webService;

  EligibilityRepo({required EligibilityWebService webService})
    : _webService = webService;

  Future<Result<EligibilityRuleList>> getEligibilityRules() async {
    return handleRepositoryCall(_webService.getEligibilityRules);
  }

  Future<Result<void>> createEligibilityRule({
    required CreateEligibilityRuleRequestModel requestBody,
  }) async {
    return handleRepositoryCall(
      () => _webService.createEligibilityRule(requestBody: requestBody),
    );
  }

  Future<Result<void>> deleteEligibilityRule(int id) async {
    return handleRepositoryCall(() => _webService.deleteEligibilityRule(id));
  }
}
