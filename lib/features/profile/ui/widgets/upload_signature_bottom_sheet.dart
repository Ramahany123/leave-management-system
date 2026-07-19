import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/language/locale_keys.g.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';
import 'package:leave_management_system/core/utils/animated_snack_dialogue.dart';
import 'package:leave_management_system/core/utils/file_picker_helper.dart';
import 'package:leave_management_system/core/widgets/custom_bottom_sheet_shell.dart';
import 'package:leave_management_system/core/widgets/primary_button_widget.dart';
import 'package:leave_management_system/features/leave_request/ui/widgets/document_upload_card.dart';
import 'package:leave_management_system/features/profile/logic/cubit/upload_signature_cubit.dart';

class UploadSignatureBottomSheet extends StatefulWidget {
  const UploadSignatureBottomSheet({super.key});

  @override
  State<UploadSignatureBottomSheet> createState() =>
      _UploadSignatureBottomSheetState();
}

class _UploadSignatureBottomSheetState
    extends State<UploadSignatureBottomSheet> {
  String? _selectedFilePath;

  Future<void> _pickSignatureFile() async {
    final String? path = await FilePickerHelper.pickDocument();
    if (path != null) {
      setState(() {
        _selectedFilePath = path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetShell(
      title: LocaleKeys.profile_upload_signature_title.tr(),
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
              message: LocaleKeys.profile_signature_upload_success.tr(),
              type: AnimatedSnackBarType.success,
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          final bool isLoading = state is UploadSignatureLoading;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DocumentUploadCard(
                docName: LocaleKeys.profile_signature_file_label.tr(),
                fileName: _selectedFilePath,
                onTap: () {
                  if (_selectedFilePath != null) {
                    setState(() => _selectedFilePath = null);
                  } else {
                    _pickSignatureFile();
                  }
                },

                isEnabled: !isLoading,
              ),
              SizedBox(height: 24.h),
              PrimaryButtonWidget(
                isLoading: isLoading,
                onPressed: _selectedFilePath != null && !isLoading
                    ? () {
                        context.read<UploadSignatureCubit>().uploadSignature(
                          _selectedFilePath!,
                        );
                      }
                    : null,
                child: Text(
                  LocaleKeys.profile_upload_signature_button.tr(),
                  style: context.textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
