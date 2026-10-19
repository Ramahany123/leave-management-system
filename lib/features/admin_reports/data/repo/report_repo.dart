import 'package:leave_management_system/core/utils/handle_repository_call.dart';
import 'package:leave_management_system/features/admin_reports/data/models/report_model.dart';
import 'package:leave_management_system/features/admin_reports/data/models/report_query.dart';
import 'package:leave_management_system/features/admin_reports/data/web_service/report_web_service.dart';

import '../../../../core/utils/result.dart';

class ReportRepo {
  final ReportWebService _webService;

  ReportRepo({required ReportWebService webService}) : _webService = webService;

  Future<Result<ReportResponseModel>> getReports(ReportQuery query) async {
    return handleRepositoryCall(() => _webService.getReport(query));
  }

  Future<Result<void>> overrideStatus(
    int id, {
    required String status,
    required String comments,
  }) async {
    return handleRepositoryCall(
      () => _webService.overrideStatus(id, status: status, comments: comments),
    );
  }
}
