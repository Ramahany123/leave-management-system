import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/routes/app_routes.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/utils/animated_snack_dialogue.dart';
import 'package:leave_management_system/features/leave_request/logic/cubit/leave_request_cubit.dart';
import 'package:leave_management_system/features/leave_request/ui/widgets/leave_request_form_body.dart';
import '../../../../core/theme/app_colors.dart';
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
      appBar: AppBar(
        title: Text(
          "Submit Leave Request",
          style: context.textTheme.titleLarge?.copyWith(
            color: context.colorScheme.onPrimary,
          ),
        ),
        backgroundColor: context.colorScheme.primary,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: context.colorScheme.onPrimary),
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

            if (state is LeaveRequestFormError) {
              return Center(
                child: GeneralErrorWidget(
                  message: state.failure.message,
                  onRetry: () => context.read<LeaveRequestCubit>().loadFormData(),
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

  void _showSuccessDialog(BuildContext context, int requestId) {
    final cubit = context.read<LeaveRequestCubit>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
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
            style: context.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                cubit.resetForm();
                context.go(AppRoutes.employeeDashboardScreen);
              },
              child: Text(
                "OK",
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
