import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/core/utils/date_extension.dart';
import 'package:leave_management_system/features/manager_reports/data/models/manager_reports_model.dart';
import 'package:leave_management_system/features/manager_reports/data/repo/manager_report_repo.dart';

import '../../../../core/networking/errors/failures.dart';

part 'manager_report_state.dart';

class ManagerReportCubit extends Cubit<ManagerReportState> {
  final ManagerReportRepo _reportRepo;
  DateTimeRange? _selectedDateRange;
  String _searchQuery = '';
  String? _selectedStatus;
  List<ReportRecord> _allRecordsList = [];
  ManagerReportsModel? _currentReportModel;

  ManagerReportCubit({required ManagerReportRepo reportRepo})
    : _reportRepo = reportRepo,
      super(ManagerReportLoading());

  Future<void> getManagerReports() async {
    emit(ManagerReportLoading());
    final result = await _reportRepo.getManagerReports(
      startDate: _selectedDateRange?.start.toApiDate,
      endDate: _selectedDateRange?.end.toApiDate,
      status: _selectedStatus,
    );
    result.fold(
      (managerReport) {
        _allRecordsList = managerReport.reports;
        _currentReportModel = managerReport;
        _applyLocalFilterAndEmit();
      },
      (failure) {
        emit(ManagerReportError(failure: failure));
      },
    );
  }

  void changeDateRangeFilter(DateTimeRange? range) {
    _selectedDateRange = range;
    getManagerReports();
  }

  void changeStatusFilter(String? status) {
    _selectedStatus = status;
    getManagerReports();
  }

  void searchReports(String query) {
    if (_currentReportModel == null) return;
    _searchQuery = query;
    _applyLocalFilterAndEmit();
  }

  void _applyLocalFilterAndEmit() {
    var filteredList = _allRecordsList;
    if (_searchQuery.isNotEmpty) {
      final exp = RegExp(RegExp.escape(_searchQuery), caseSensitive: false);
      filteredList = filteredList.where((record) {
        final nameMatch = exp.hasMatch(record.employeeName);
        final deptMatch = exp.hasMatch(record.department);
        return nameMatch || deptMatch;
      }).toList();
    }
    emit(
      ManagerReportSuccess(
        managerReportsModel: _currentReportModel!,
        filteredReports: filteredList,
        selectedStatus: _selectedStatus,
        selectedRange: _selectedDateRange,
      ),
    );
  }
}
