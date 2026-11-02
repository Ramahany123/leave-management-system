import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_management_system/features/admin_reports/data/models/report_model.dart';
import 'package:leave_management_system/features/admin_reports/data/models/report_query.dart';

import '../../../../core/networking/errors/failures.dart';
import '../../../../core/utils/result.dart';
import '../../data/repo/report_repo.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  final ReportRepo _repo;

  int _requestGeneration = 0;

  ReportCubit({required ReportRepo repo}) : _repo = repo, super(ReportState());

  ReportQuery get reportQuery => state.query;
  ReportQuery _queryAfterPage(
    ReportQuery requestQuery,
    ReportResponseModel response,
  ) {
    final nextOffset = response.leaveRequests.isEmpty
        ? response.total
        : requestQuery.offset + response.leaveRequests.length;

    return requestQuery.copyWith(offset: nextOffset);
  }

  Future<void> applyQuery(ReportQuery query) async {
    final requestQuery = query.copyWith(offset: 0);
    final requestGeneration = ++_requestGeneration;

    emit(
      state.copyWith(
        isInitialLoading: true,
        isRefreshing: false,
        isLoadingMore: false,
        initialFailure: null,
        refreshFailure: null,
        loadMoreFailure: null,
        requests: const [],
        total: 0,
        query: requestQuery,
      ),
    );

    final result = await _fetchReports(
      requestQuery: requestQuery,
      requestGeneration: requestGeneration,
    );

    if (result == null) return;

    result.fold(
      (response) {
        emit(
          state.copyWith(
            requests: response.leaveRequests,
            total: response.total,
            query: _queryAfterPage(requestQuery, response),
            isInitialLoading: false,
          ),
        );
      },
      (failure) {
        emit(state.copyWith(isInitialLoading: false, initialFailure: failure));
      },
    );
  }

  void changeStatusFilter(String? newStatus) {
    if (newStatus == state.query.status) return;
    applyQuery(state.query.copyWith(status: newStatus));
  }

  Future<void> refreshReports() async {
    if (state.isInitialLoading || state.isRefreshing || state.isLoadingMore) {
      return;
    }

    final requestQuery = state.query.copyWith(offset: 0);
    final requestGeneration = _requestGeneration;

    emit(
      state.copyWith(
        isRefreshing: true,
        refreshFailure: null,
        loadMoreFailure: null,
      ),
    );

    final result = await _fetchReports(
      requestQuery: requestQuery,
      requestGeneration: requestGeneration,
    );

    if (result == null) return;

    result.fold(
      (response) {
        emit(
          state.copyWith(
            requests: response.leaveRequests,
            total: response.total,
            query: _queryAfterPage(requestQuery, response),
            isRefreshing: false,
          ),
        );
      },
      (failure) {
        emit(state.copyWith(isRefreshing: false, refreshFailure: failure));
      },
    );
  }

  Future<void> loadMoreReports() async {
    if (state.isInitialLoading ||
        state.isRefreshing ||
        state.isLoadingMore ||
        state.requests.length >= state.total ||
        state.query.offset >= state.total) {
      return;
    }

    final requestQuery = state.query;
    final requestGeneration = _requestGeneration;

    emit(state.copyWith(isLoadingMore: true, loadMoreFailure: null));

    final result = await _fetchReports(
      requestQuery: requestQuery,
      requestGeneration: requestGeneration,
    );

    if (result == null) return;

    result.fold(
      (response) {
        final existingIds = state.requests
            .map((request) => request.requestId)
            .toSet();
        final freshRequests = response.leaveRequests.where(
          (r) => !existingIds.contains(r.requestId),
        );
        emit(
          state.copyWith(
            requests: [...state.requests, ...freshRequests],
            total: response.total,
            query: _queryAfterPage(requestQuery, response),
            isLoadingMore: false,
          ),
        );
      },
      (failure) {
        emit(state.copyWith(isLoadingMore: false, loadMoreFailure: failure));
      },
    );
  }

  Future<Result<ReportResponseModel>?> _fetchReports({
    required ReportQuery requestQuery,
    required int requestGeneration,
  }) async {
    final result = await _repo.getReports(requestQuery);

    // Ignore results from a request that is no longer relevant.
    if (isClosed || requestGeneration != _requestGeneration) {
      return null;
    }

    return result;
  }
}
