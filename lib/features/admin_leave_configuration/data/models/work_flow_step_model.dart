class WorkflowStep {
  final int stepOrder;
  final String approverRole;

  WorkflowStep({required this.stepOrder, required this.approverRole});

  factory WorkflowStep.fromJson(Map<String, dynamic> json) {
    return WorkflowStep(
      stepOrder: json['step_order'] as int,
      approverRole: json['approver_role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'step_order': stepOrder, 'approver_role': approverRole};
  }
}
