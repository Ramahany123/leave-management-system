import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/models/leave_request_details_model.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/utils/request_status_extension.dart';
import 'package:leave_management_system/core/widgets/build_info_section.dart';
import 'package:leave_management_system/core/widgets/custom_bottom_sheet_shell.dart';
import 'package:leave_management_system/core/widgets/status_badging.dart';
import 'package:leave_management_system/features/leave_history/logic/cubit/leave_request_details_cubit.dart';
import 'package:leave_management_system/features/leave_history/ui/widgets/request_details_shimmer.dart';
import '../../../../core/utils/date_extension.dart';
import '../../../../core/widgets/general_error_widget.dart';
import '../../../../core/widgets/key_value_row_widget.dart';

class RequestDetailsBottomSheet extends StatelessWidget {
  final int requestId;
  const RequestDetailsBottomSheet({super.key, required this.requestId});

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetShell(
      title: LocaleKeys.leave_history_details_title.tr(),
      content: Flexible(
        child: BlocBuilder<LeaveRequestDetailsCubit, LeaveRequestDetailsState>(
          builder: (context, state) {
            return switch (state) {
              LeaveRequestDetailsInitial() ||
              LeaveRequestDetailsLoading() => const RequestDetailsShimmer(),
              LeaveRequestDetailsError(failure: final f) => Center(
                child: GeneralErrorWidget(
                  message: f.message,
                  onRetry: () => context
                      .read<LeaveRequestDetailsCubit>()
                      .getLeaveRequestDetails(requestId),
                ),
              ),
              LeaveRequestDetailsSuccess(
                leaveRequestDetails: final leaveRequestDetails,
              ) =>
                _buildBottomSheetContent(context, leaveRequestDetails),
            };
          },
        ),
      ),
    );
  }

  Widget _buildBottomSheetContent(
    BuildContext context,
    LeaveRequestDetailsModel leaveRequestDetails,
  ) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildInfoSection(
            context,
            LocaleKeys.leave_history_leave_information.tr(),
            [
              KeyValueRow(
                label: LocaleKeys.leave_history_type.tr(),
                value: leaveRequestDetails.leaveType.typeName,
              ),
              KeyValueRow(
                label: LocaleKeys.leave_history_status.tr(),
                widget: StatusBadging(status: leaveRequestDetails.status),
              ),
              KeyValueRow(
                label: LocaleKeys.leave_history_duration.tr(),
                value: LocaleKeys.leave_history_days_format.tr(
                  namedArgs: {'count': leaveRequestDetails.duration.toString()},
                ),
              ),
              KeyValueRow(
                label: LocaleKeys.leave_history_reason.tr(),
                value: leaveRequestDetails.reason,
              ),
            ],
          ),
          SizedBox(height: 24.h),

          buildInfoSection(
            context,
            LocaleKeys.leave_history_timing_details.tr(),
            [
              KeyValueRow(
                label: LocaleKeys.leave_history_start_date.tr(),
                value: leaveRequestDetails.startDate.toReadableDate,
              ),
              KeyValueRow(
                label: LocaleKeys.leave_history_end_date.tr(),
                value: leaveRequestDetails.endDate.toReadableDate,
              ),
              if (leaveRequestDetails.returnedAt != null)
                KeyValueRow(
                  label: LocaleKeys.leave_history_returned_at.tr(),
                  value: leaveRequestDetails.returnedAt!.toReadableDate,
                ),
              KeyValueRow(
                label: LocaleKeys.leave_history_applied_on.tr(),
                value: leaveRequestDetails.createdAt.toReadableDate,
              ),
            ],
          ),
          SizedBox(height: 24.h),

          buildInfoSection(
            context,
            LocaleKeys.leave_history_additional_details.tr(),
            [
              KeyValueRow(
                label: LocaleKeys.leave_history_pre_leave_ack.tr(),
                value: leaveRequestDetails.preLeaveAcknowledgement
                    ? LocaleKeys.leave_history_completed.tr()
                    : LocaleKeys.leave_history_pending.tr(),
              ),
              KeyValueRow(
                label: LocaleKeys.leave_history_attachments.tr(),
                value: LocaleKeys.leave_history_files_format.tr(
                  namedArgs: {
                    'count': leaveRequestDetails.attachments.length.toString(),
                  },
                ),
              ),
              if (leaveRequestDetails.delegateUserId != null)
                KeyValueRow(
                  label: LocaleKeys.leave_history_delegate_id.tr(),
                  value: leaveRequestDetails.delegateUserId.toString(),
                ),
              KeyValueRow(
                label: LocaleKeys.leave_history_approval_steps.tr(),
                value: LocaleKeys.leave_history_steps_format.tr(
                  namedArgs: {
                    'count': leaveRequestDetails.approvalSteps.length.toString(),
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          _buildApprovalTimeline(context, leaveRequestDetails.approvalSteps),
        ],
      ),
    );
  }

  Widget _buildApprovalTimeline(
    BuildContext context,
    List<DetailApprovalStep> steps,
  ) {
    if (steps.isEmpty) return const SizedBox.shrink();
    return buildInfoSection(
      context,
      LocaleKeys.leave_history_approval_timeline.tr(),
      [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: steps.length,
          itemBuilder: (context, index) {
            final step = steps[index];
            return _ApprovalStepTile(
              step: step,
              isLast: index == steps.length - 1,
            );
          },
        ),
      ],
    );
  }
}

class _ApprovalStepTile extends StatelessWidget {
  final DetailApprovalStep step;
  final bool isLast;

  const _ApprovalStepTile({required this.step, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final statusColor = step.status.getStatusColor;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 28.w,
                height: 28.h,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(color: statusColor, width: 2.w),
                ),
                child: Icon(
                  step.status.getStatusIcon,
                  color: statusColor,
                  size: 14.sp,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2.w,
                    color: context.colorScheme.outline,
                  ),
                ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        step.displayName,
                        style: context.textTheme.titleSmall,
                      ),
                      Text(
                        step.status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    step.roleAtApproval,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (step.comments != null && step.comments!.isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: context.colorScheme.outline.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: context.colorScheme.outline.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        step.comments!,
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
