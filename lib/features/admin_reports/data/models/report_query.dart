import 'package:leave_management_system/core/utils/date_extension.dart';

const Object _unset = Object();

class ReportQuery {
  final String? status;
  final int? departmentId;
  final int? typeId;
  final int? userId;
  final DateTime? startDate;
  final DateTime? endDate;
  final int limit;
  final int offset;

  const ReportQuery({
    this.status,
    this.departmentId,
    this.typeId,
    this.userId,
    this.startDate,
    this.endDate,
    this.limit = 10,
    this.offset = 0,
  });

  bool get hasActiveFilters =>
      departmentId != null ||
      typeId != null ||
      userId != null ||
      startDate != null ||
      endDate != null;
  bool get hasAnyCriteria => status != null || hasActiveFilters;

  Map<String, dynamic> toQueryParameters() {
    final queryParams = <String, dynamic>{
      'status': status,
      'department_id': departmentId,
      'type_id': typeId,
      'user_id': userId,
      'start_date': startDate?.toApiDate,
      'end_date': endDate?.toApiDate,
      'limit': limit,
      'offset': offset,
    }..removeWhere((key, value) => value == null);
    return queryParams;
  }

  ReportQuery copyWith({
    Object? status = _unset,
    Object? departmentId = _unset,
    Object? typeId = _unset,
    Object? userId = _unset,
    Object? startDate = _unset,
    Object? endDate = _unset,
    int? limit,
    int? offset,
  }) {
    return ReportQuery(
      status: status != _unset ? status as String? : this.status,
      departmentId: departmentId != _unset
          ? departmentId as int?
          : this.departmentId,
      typeId: typeId != _unset ? typeId as int? : this.typeId,
      userId: userId != _unset ? userId as int? : this.userId,
      startDate: startDate != _unset ? startDate as DateTime? : this.startDate,
      endDate: endDate != _unset ? endDate as DateTime? : this.endDate,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }
}
