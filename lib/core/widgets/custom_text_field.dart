import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextInputType? textInputType;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isEnabled;
  final List<TextInputFormatter>? textInputFormatter;
  const CustomTextField({
    super.key,
    this.hintText,
    this.textInputType,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.isEnabled = true,
    this.textInputFormatter,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscured;

  @override
  void initState() {
    _isObscured = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 331.w,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: TextFormField(
          inputFormatters: widget.textInputFormatter,
          enabled: widget.isEnabled,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.textInputType ?? TextInputType.text,
          obscureText: _isObscured,
          cursorColor: context.colorScheme.primary,
          style: context.textTheme.bodyMedium?.copyWith(
            color: widget.isEnabled
                ? context.colorScheme.onSurface
                : context.colorScheme.onSurfaceVariant,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: widget.isEnabled
                ? context.colorScheme.surface
                : context.colorScheme.outline.withValues(alpha: 0.15),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 18.w,
              vertical: 18.h,
            ),
            hintText: widget.hintText,
            hintStyle: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: context.colorScheme.outline),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: context.colorScheme.outline.withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: context.colorScheme.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: context.colorScheme.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: context.colorScheme.error, width: 1.5),
            ),
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                    child: Icon(
                      _isObscured ? Icons.visibility_off : Icons.visibility,
                      color: context.colorScheme.onSurfaceVariant,
                      size: 22.sp,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
