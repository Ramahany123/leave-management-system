import 'package:dio/dio.dart';
import 'package:leave_management_system/core/networking/api_endpoints.dart';
import 'package:leave_management_system/core/networking/api_service.dart';

import '../models/create_eligibility_rule_request_model.dart';
import '../models/eligibility_rule_model.dart';

class EligibilityWebService {
  final ApiService _apiService;

  EligibilityWebService({required ApiService apiService})
    : _apiService = apiService;

  Future<EligibilityRuleList> getEligibilityRules() async {
    final Response response = await _apiService.getRequest(
      apiEndpoint: ApiEndpoints.adminEligibilityRules,
    );
    return EligibilityRuleList.fromJson(response.data);
  }

  Future<void> createEligibilityRule({
    required CreateEligibilityRuleRequestModel requestBody,
  }) async {
    await _apiService.postRequest(
      apiEndpoint: ApiEndpoints.adminEligibilityRules,
      data: requestBody.toJson(),
    );
  }

  Future<void> deleteEligibilityRule(int id) async {
    // 204 + empty body — response deliberately ignored, same as delete.
    await _apiService.deleteRequest(
      apiEndpoint: ApiEndpoints.adminEligibilityRule(id),
    );
  }
}
