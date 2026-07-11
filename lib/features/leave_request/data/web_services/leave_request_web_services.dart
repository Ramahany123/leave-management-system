import 'package:dio/dio.dart';
import 'package:leave_management_system/core/networking/api_endpoints.dart';
import 'package:leave_management_system/core/networking/api_service.dart';
import 'package:leave_management_system/features/leave_request/data/models/delegate_user_model.dart';
import 'package:leave_management_system/features/leave_request/data/models/eligible_leave_type_model.dart';
import 'package:leave_management_system/features/leave_request/data/models/leave_requet_body_model.dart';

import '../models/create_leave_request_response_model.dart';

class LeaveRequestWebServices {
  final ApiService _apiService;

  LeaveRequestWebServices({required ApiService apiService})
    : _apiService = apiService;

  Future<EligibleLeaveTypesResponseModel> getEligibleLeaveTypes() async {
    final Response response = await _apiService.getRequest(
      apiEndpoint: ApiEndpoints.getEligibleLeaveTypes,
    );
    return EligibleLeaveTypesResponseModel.fromJson(response.data);
  }

  Future<DelegateUsersResponseModel> getDelegateUsers() async {
    final Response response = await _apiService.getRequest(
      apiEndpoint: ApiEndpoints.getDelegateUsers,
    );
    return DelegateUsersResponseModel.fromJson(response.data);
  }

  Future<CreateLeaveRequestResponseModel> createLeaveRequest(
    LeaveRequestBodyModel body,
  ) async {
    Map<String, dynamic> fields = {
      "start_date": body.startDate.toIso8601String().split("T").first,
      "end_date": body.endDate.toIso8601String().split("T").first,
      "type_id": body.typeId,
      "reason": body.reason,
      "pre_leave_acknowledgement": body.preLeaveAcknowledgement,
    };

    if (body.delegateUserId != null) {
      fields["delegate_user_id"] = body.delegateUserId;
    }

    if (body.documentFiles != null && body.documentFiles!.isNotEmpty) {
      for (final entry in body.documentFiles!.entries) {
        int documentID = entry.key;
        String filePath = entry.value;

        fields["doc_$documentID"] = await MultipartFile.fromFile(
          filePath,
          filename: filePath.split("/").last,
        );
      }
    }
    FormData formData = FormData.fromMap(fields);

    final Response response = await _apiService.postRequest(
      apiEndpoint: ApiEndpoints.createLeaveRequest,
      data: formData,
    );

    return CreateLeaveRequestResponseModel.fromJson(response.data);
  }
}
