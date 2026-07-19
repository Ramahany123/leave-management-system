import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/utils/animated_snack_dialogue.dart';
import 'package:leave_management_system/core/utils/file_picker_helper.dart';
import 'package:leave_management_system/core/widgets/custom_bottom_sheet_shell.dart';
import 'package:leave_management_system/core/widgets/primary_button_widget.dart';
import 'package:leave_management_system/features/leave_request/ui/widgets/document_upload_card.dart';
import 'package:leave_management_system/features/profile/logic/cubit/upload_signature_cubit.dart';

import '../../../../core/theme/theme_context_extension.dart';

class UploadSignatureBottomSheet extends StatefulWidget {
  const UploadSignatureBottomSheet({super.key});

  @override
  State<UploadSignatureBottomSheet> createState() =>
      _UploadSignatureBottomSheetState();
}

class _UploadSignatureBottomSheetState
    extends State<UploadSignatureBottomSheet> {
  String? _selectedFile;
  Future<void> _pickSignatureFile() async {
    final path = await FilePickerHelper.pickDocument();
    if (path != null) {
      setState(() {
        _selectedFile = path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetShell(
      title: "Upload Signature",
      content: BlocConsumer<UploadSignatureCubit, UploadSignatureState>(
        listener: (context, state) {
          if (!context.mounted) return;
          if (state is UploadSignatureError) {
            showAnimatedSnakDialogue(
              context,
              message: state.failure.message,
              type: AnimatedSnackBarType.error,
            );
          } else if (state is UploadSignatureSuccess) {
            showAnimatedSnakDialogue(
              context,
              message: "Signature uploaded successfully",
              type: AnimatedSnackBarType.success,
            );
            GoRouter.of(context).pop();
          }
        },
        builder: (context, state) {
          final bool isLoading = state is UploadSignatureLoading;
          return PopScope(
            canPop: !isLoading,
            child: Column(
              children: [
                DocumentUploadCard(
                  docName: "Signature Image / Document",
                  fileName: _selectedFile,
                  onTap: () {
                    if (_selectedFile != null) {
                      setState(() {
                        _selectedFile = null;
                      });
                    } else {
                      _pickSignatureFile();
                    }
                  },
                  isEnabled: !isLoading,
                ),
                SizedBox(height: 24.h),
                PrimaryButtonWidget(
                  isLoading: isLoading,
                  onPressed: _selectedFile != null && !isLoading
                      ? () {
                          context.read<UploadSignatureCubit>().uploadSignature(
                            _selectedFile!,
                          );
                        }
                      : null,
                  child: Text(
                    "Upload Signature",
                    style: context.textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
