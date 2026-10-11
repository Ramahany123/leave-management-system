part of 'eligibility_cubit.dart';

@immutable
final class EligibilityState {
  final List<EligibilityRule> rules;
  final InitialLoadingStatus initialLoadingStatus;
  final bool isRefreshing;
  final bool isCreating;
  final int? deletingId;
  final Failure? getRulesFailure;
  final Failure? refreshFailure;
  final Failure? deleteRuleFailure;
  final Failure? createRuleFailure;
  final bool createSuccess;

  const EligibilityState({
    this.rules = const [],
    this.initialLoadingStatus = InitialLoadingStatus.initial,
    this.isRefreshing = false,
    this.isCreating = false,
    this.deletingId,
    this.getRulesFailure,
    this.refreshFailure,
    this.deleteRuleFailure,
    this.createRuleFailure,
    this.createSuccess = false,
  });

  static const _unset = Object();

  EligibilityState copyWith({
    List<EligibilityRule>? rules,
    InitialLoadingStatus? initialLoadingStatus,
    bool? isRefreshing,
    bool? isCreating,
    Object? deletingId = _unset,
    Object? getRulesFailure = _unset,
    Object? refreshFailure = _unset,
    Object? deleteRuleFailure = _unset,
    Object? createRuleFailure = _unset,
    bool? createSuccess,
  }) {
    return EligibilityState(
      rules: rules ?? this.rules,
      initialLoadingStatus: initialLoadingStatus ?? this.initialLoadingStatus,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isCreating: isCreating ?? this.isCreating,
      deletingId: deletingId == _unset ? this.deletingId : deletingId as int?,
      getRulesFailure: getRulesFailure == _unset
          ? this.getRulesFailure
          : getRulesFailure as Failure?,
      refreshFailure: refreshFailure == _unset
          ? this.refreshFailure
          : refreshFailure as Failure?,
      deleteRuleFailure: deleteRuleFailure == _unset
          ? this.deleteRuleFailure
          : deleteRuleFailure as Failure?,
      createRuleFailure: createRuleFailure == _unset
          ? this.createRuleFailure
          : createRuleFailure as Failure?,
      createSuccess: createSuccess ?? this.createSuccess,
    );
  }
}
