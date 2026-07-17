import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/routes/app_routes.dart';
import 'package:leave_management_system/core/utils/animated_snack_dialogue.dart';
import 'package:leave_management_system/core/utils/date_picker_helper.dart';
import 'package:leave_management_system/core/utils/file_picker_helper.dart';
import 'package:leave_management_system/core/utils/service_locator.dart';
import 'package:leave_management_system/core/widgets/custom_date_selector.dart';
import 'package:leave_management_system/features/leave_request/data/models/delegate_user_model.dart';
import 'package:leave_management_system/features/leave_request/logic/cubit/leave_request_cubit.dart';
import 'package:leave_management_system/features/leave_request/ui/widgets/custom_drop_down.dart';
import 'package:leave_management_system/features/leave_request/ui/widgets/document_upload_card.dart';
import 'package:leave_management_system/features/leave_request/ui/widgets/signature_warning_card.dart';
import 'package:leave_management_system/features/profile/data/repo/profile_repo.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/general_error_widget.dart';
import '../../../../core/widgets/primary_button_widget.dart';
import '../../data/models/eligible_leave_type_model.dart';
import '../widgets/leave_request_shimmer.dart';
import '../widgets/undertaking_card.dart';

class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen({super.key});

  @override
  State<LeaveRequestScreen> createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

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

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          "Submit Leave Request",
          style: AppTextStyles.black20w600TextStyle.copyWith(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primaryBlue,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: BlocConsumer<LeaveRequestCubit, LeaveRequestState>(
          listener: (context, state) {
            if (state is LeaveRequestSubmitSuccess) {
              _showSuccessDialog(
                context,
                state.createLeaveRequestResponse.requestId,
              );
            } else if (state is LeaveRequestSubmitError) {
              showAnimatedSnakDialogue(
                context,
                type: AnimatedSnackBarType.error,
                message: state.failure.message,
              );
            }
          },
          builder: (context, state) {
            final bool hasElectronicSignature =
                sl<ProfileRepo>().currentUser?.signatureUrl != null &&
                sl<ProfileRepo>().currentUser!.signatureUrl!.isNotEmpty;
            if (state is LeaveRequestFormLoading) {
              return const Padding(
                padding: EdgeInsets.all(20.0),
                child: LeaveRequestShimmer(),
              );
            }

            // B. Dropdown lists failed to load
            if (state is LeaveRequestFormError) {
              return Center(
                child: GeneralErrorWidget(
                  message: state.failure.message,
                  onRetry: () => cubit.loadFormData(),
                ),
              );
            }

            if (state is LeaveRequestFormSuccess) {
              final fields = state.formFields;
              final bool isSubmitLoading = state is LeaveRequestSubmitLoading;
              final bool isFormActive =
                  !isSubmitLoading && hasElectronicSignature;
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    sliver: SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!hasElectronicSignature) ...[
                            SignatureWarningCard(
                              onUploadPressed: () {
                                GoRouter.of(
                                  context,
                                ).goNamed(AppRoutes.profileScreen);
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
                                      onTap: () => _handleDateSelection(
                                        context,
                                        cubit,
                                        true,
                                      ),
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
                                      onTap: () => _handleDateSelection(
                                        context,
                                        cubit,
                                        false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          _buildFormLabel("Reason"),
                          CustomTextField(
                            hintText:
                                "Enter the justification for this request...",
                            controller: _reasonController,
                            isEnabled: isFormActive,
                            textInputType: TextInputType.text,
                          ),
                          SizedBox(height: 16.h),
                          if (fields.selectedLeaveType?.requiresDelegate ==
                              true) ...[
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
                          if (fields.selectedLeaveType?.requiresDocument ==
                              true) ...[
                            _buildFormLabel("Required Attachments"),
                            ...fields.selectedLeaveType!.requiredDocuments.map((
                              doc,
                            ) {
                              final docId = doc.documentRequirementId;
                              final bool isFileUploaded = fields.selectedFiles
                                  .containsKey(docId);

                              return Padding(
                                padding: EdgeInsetsDirectional.only(
                                  bottom: 12.h,
                                ),
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
                          const Spacer(),
                          SizedBox(height: 24.h),
                          Center(
                            child: PrimaryButtonWidget(
                              isLoading: isSubmitLoading,
                              onPressed: hasElectronicSignature
                                  ? () {
                                      // Sync local text controller text to Cubit memory before posting
                                      cubit.updateReason(
                                        _reasonController.text,
                                      );
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
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

// --- Sub-widgets Helper methods ---

Widget _buildFormLabel(String labelText) {
  return Align(
    alignment: AlignmentDirectional.centerStart,
    child: Padding(
      padding: EdgeInsetsDirectional.only(bottom: 6.h, start: 4.w),
      child: Text(labelText, style: AppTextStyles.black14w600TextStyle),
    ),
  );
}

void _showSuccessDialog(BuildContext context, int requestId) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.successGreen),
            SizedBox(width: 8),
            Text("Request Submitted"),
          ],
        ),
        content: Text(
          "Your leave request (#$requestId) has been submitted successfully and is pending delegation and manager approvals.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              GoRouter.of(context).pop(); // Pops Dialog
              GoRouter.of(context).goNamed(AppRoutes.employeeDashboardScreen);
            },
            child: const Text(
              "OK",
              style: TextStyle(color: AppColors.primaryBlue),
            ),
          ),
        ],
      );
    },
  );
}
