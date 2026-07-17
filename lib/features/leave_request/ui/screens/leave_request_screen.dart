import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/routes/app_routes.dart';
import 'package:leave_management_system/core/utils/animated_snack_dialogue.dart';
import 'package:leave_management_system/features/leave_request/logic/cubit/leave_request_cubit.dart';
import 'package:leave_management_system/features/leave_request/ui/widgets/leave_request_form_body.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/general_error_widget.dart';
import '../widgets/leave_request_shimmer.dart';

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

  @override
  Widget build(BuildContext context) {
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
                  onRetry: () =>
                      context.read<LeaveRequestCubit>().loadFormData(),
                ),
              );
            }

            if (state is LeaveRequestFormSuccess) {
              return LeaveRequestFormBody(
                state: state,
                reasonController: _reasonController,
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
