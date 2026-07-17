import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/routes/app_routes.dart';
import 'package:leave_management_system/core/styles/app_colors.dart';
import 'package:leave_management_system/core/styles/app_text_styles.dart';
import 'package:leave_management_system/core/utils/date_picker_helper.dart';
import 'package:leave_management_system/core/utils/file_picker_helper.dart';
import 'package:leave_management_system/core/utils/service_locator.dart';
import 'package:leave_management_system/core/widgets/custom_text_field.dart';
import 'package:leave_management_system/core/widgets/primary_button_widget.dart';
import 'package:leave_management_system/features/profile/data/repo/profile_repo.dart';
import 'package:leave_management_system/features/leave_request/logic/cubit/leave_request_cubit.dart';
import 'package:leave_management_system/features/leave_request/ui/widgets/signature_warning_card.dart';
import 'package:leave_management_system/features/leave_request/ui/widgets/document_upload_card.dart';
import 'package:leave_management_system/features/leave_request/ui/widgets/undertaking_card.dart';
import 'package:leave_management_system/features/leave_request/data/models/delegate_user_model.dart';
import 'package:leave_management_system/features/leave_request/data/models/eligible_leave_type_model.dart';

import '../../../../core/widgets/custom_date_selector.dart';
import 'custom_drop_down.dart';

class LeaveRequestFormBody extends StatelessWidget {
  final LeaveRequestFormSuccess state;
  final TextEditingController reasonController;
  const LeaveRequestFormBody({
    super.key,
    required this.state,
    required this.reasonController,
  });

  Future<void> _handleDateSelection(
    BuildContext context,
    LeaveRequestCubit cubit,
    bool isStartDate,
  ) async {
    final date = await DatePickerHelper.pickDate(context);
    if (date != null) {
      if (isStartDate) {
        cubit.selectStartDate(date);
      } else {
        cubit.selectEndDate(date);
      }
    }
  }

  Future<void> _handleFileSelection(
    int requirementId,
    LeaveRequestCubit cubit,
  ) async {
    final path = await FilePickerHelper.pickDocument();
    if (path != null) {
      cubit.addFile(requirementId, path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LeaveRequestCubit>();
    final bool hasElectronicSignature =
        sl<ProfileRepo>().currentUser?.signatureUrl != null &&
        sl<ProfileRepo>().currentUser!.signatureUrl!.isNotEmpty;
    final fields = state.formFields;
    final bool isSubmitLoading = state is LeaveRequestSubmitLoading;
    final bool isFormActive = !isSubmitLoading && hasElectronicSignature;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          sliver: SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!hasElectronicSignature) ...[
                  SignatureWarningCard(
                    onUploadPressed: () {
                      GoRouter.of(context).goNamed(AppRoutes.profileScreen);
                    },
                  ),
                  SizedBox(height: 16.h),
                ],
                _buildFormLabel("Leave Type"),
                CustomDropDown<EligibleLeaveTypeModel>(
                  hint: "Choose Leave Type...",
                  value: fields.selectedLeaveType,
                  items: state.eligibleLeaveTypes,
                  itemAsString: (type) => type.typeName,
                  onChanged: (type) {
                    if (type != null) {
                      cubit.selectLeaveType(type);
                    }
                  },
                  isEnabled: isFormActive,
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          _buildFormLabel("Start Date"),
                          CustomDateSelector(
                            isEnabled: isFormActive,
                            hint: "YYYY-MM-DD",
                            selectedDate: fields.startDate,
                            onTap: () =>
                                _handleDateSelection(context, cubit, true),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFormLabel("End Date"),
                          CustomDateSelector(
                            selectedDate: fields.endDate,
                            hint: "YYYY-MM-DD",
                            isEnabled: isFormActive,
                            onTap: () =>
                                _handleDateSelection(context, cubit, false),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                _buildFormLabel("Reason"),
                CustomTextField(
                  hintText: "Enter the justification for this request...",
                  controller: reasonController,
                  isEnabled: isFormActive,
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 16.h),
                if (fields.selectedLeaveType?.requiresDelegate == true) ...[
                  _buildFormLabel("Delegate"),
                  CustomDropDown<DelegateUserModel>(
                    isEnabled: isFormActive,
                    hint: "Select a colleague to delegate...",
                    value: fields.selectedDelegate,
                    items: state.delegateUsers,
                    itemAsString: (delegateUser) =>
                        "${delegateUser.name} (${delegateUser.jobTitle})",
                    onChanged: (user) {
                      if (user != null) {
                        cubit.selectDelegate(user);
                      }
                    },
                  ),
                  SizedBox(height: 16.h),
                ],
                if (fields.selectedLeaveType?.requiresDocument == true) ...[
                  _buildFormLabel("Required Attachments"),
                  ...fields.selectedLeaveType!.requiredDocuments.map((doc) {
                    final docId = doc.documentRequirementId;
                    final bool isFileUploaded = fields.selectedFiles
                        .containsKey(docId);

                    return Padding(
                      padding: EdgeInsetsDirectional.only(bottom: 12.h),
                      child: DocumentUploadCard(
                        isEnabled: isFormActive,
                        docName: doc.documentName,
                        fileName: fields.selectedFiles[docId],
                        onTap: () {
                          if (isFileUploaded) {
                            cubit.removeFile(docId);
                          } else {
                            _handleFileSelection(docId, cubit);
                          }
                        },
                      ),
                    );
                  }),
                  SizedBox(height: 8.h),
                ],

                UndertakingCard(
                  value: fields.preLeaveAcknowledgement,
                  isEnabled: isFormActive,
                  onChanged: (value) {
                    if (value != null) {
                      cubit.toggleAcknowledgement(value);
                    }
                  },
                ),
                if (MediaQuery.of(context).viewInsets.bottom == 0)
                  const Spacer()
                else
                  SizedBox(height: 24.h),
                SizedBox(height: 24.h),
                Center(
                  child: PrimaryButtonWidget(
                    isLoading: isSubmitLoading,
                    onPressed: hasElectronicSignature
                        ? () {
                            // Sync local text controller text to Cubit memory before posting
                            cubit.updateReason(reasonController.text);
                            cubit.submitLeaveRequest();
                          }
                        : () {},
                    backgroundColor: hasElectronicSignature
                        ? AppColors.primaryBlue
                        : Colors.grey.shade400,
                    child: Text(
                      "Submit Request",
                      style: AppTextStyles.white16w600TextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildFormLabel(String labelText) {
  return Align(
    alignment: AlignmentDirectional.centerStart,
    child: Padding(
      padding: EdgeInsetsDirectional.only(bottom: 6.h, start: 4.w),
      child: Text(labelText, style: AppTextStyles.black14w600TextStyle),
    ),
  );
}
