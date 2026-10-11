import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/networking/errors/failures.dart';
import '../../../../core/utils/result.dart';
import '../../data/models/create_eligibility_rule_request_model.dart';
import '../../data/models/eligibility_rule_model.dart';
import '../../data/repo/eligibility_repo.dart';
import '../initial_loading_status.dart';

part 'eligibility_state.dart';

class EligibilityCubit extends Cubit<EligibilityState> {
  final EligibilityRepo _repo;

  EligibilityCubit({required EligibilityRepo repo})
    : _repo = repo,
      super(EligibilityState());

  void _safeEmit(EligibilityState newState) {
    if (!isClosed) emit(newState);
  }

  Future<Result<EligibilityRuleList>?> _fetch() async {
    if (state.deletingId != null) return null;
    final result = await _repo.getEligibilityRules();
    if (isClosed) return null;
    return result;
  }

  Future<void> getEligibilityRules() async {
    if (state.initialLoadingStatus == InitialLoadingStatus.loading) return;
    _safeEmit(
      state.copyWith(
        initialLoadingStatus: InitialLoadingStatus.loading,
        getRulesFailure: null,
      ),
    );

    final result = await _fetch();
    if (result == null) return;

    result.fold(
      (ruleList) {
        _safeEmit(
          state.copyWith(
            initialLoadingStatus: InitialLoadingStatus.success,
            rules: ruleList.list,
          ),
        );
      },
      (failure) {
        _safeEmit(
          state.copyWith(
            initialLoadingStatus: InitialLoadingStatus.failure,
            getRulesFailure: failure,
          ),
        );
      },
    );
  }

  Future<void> refresh() async {
    if (state.isRefreshing || state.deletingId != null) return;
    _safeEmit(state.copyWith(isRefreshing: true, refreshFailure: null));

    final result = await _fetch();
    if (result == null) {
      _safeEmit(state.copyWith(isRefreshing: false));
      return;
    }

    result.fold(
      (ruleList) {
        _safeEmit(state.copyWith(isRefreshing: false, rules: ruleList.list));
      },
      (failure) {
        _safeEmit(state.copyWith(isRefreshing: false, refreshFailure: failure));
      },
    );
  }

  Future<void> createEligibilityRule({
    required CreateEligibilityRuleRequestModel requestBody,
  }) async {
    if (state.isCreating) return;
    _safeEmit(
      state.copyWith(
        isCreating: true,
        createRuleFailure: null,
        createSuccess: false,
      ),
    );

    final result = await _repo.createEligibilityRule(requestBody: requestBody);
    if (isClosed) return;

    result.fold(
      (_) {
        _safeEmit(state.copyWith(isCreating: false, createSuccess: true));
        refresh();
      },
      (failure) {
        _safeEmit(
          state.copyWith(isCreating: false, createRuleFailure: failure),
        );
      },
    );
  }

  Future<void> deleteEligibilityRule(int id) async {
    if (state.isRefreshing || state.deletingId != null) return;
    _safeEmit(state.copyWith(deletingId: id, deleteRuleFailure: null));

    final result = await _repo.deleteEligibilityRule(id);
    if (isClosed) return;

    result.fold(
      (_) {
        _allRemove(id);
        _safeEmit(state.copyWith(deletingId: null));
      },
      (failure) {
        _safeEmit(
          state.copyWith(deletingId: null, deleteRuleFailure: failure),
        );
      },
    );
  }

  void _allRemove(int id) {
    final updated = List<EligibilityRule>.from(state.rules)
      ..removeWhere((rule) => rule.eligibilityId == id);
    _safeEmit(state.copyWith(rules: updated));
  }
}
