import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextInputType? textInputType;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    this.hintText,
    this.textInputType,
    this.isPassword = false,
    this.controller,
    this.validator,
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
      // height: 56.h,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.textInputType ?? TextInputType.none,
          obscureText: _isObscured,
          cursorColor: AppColors.primaryBlue,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 18.w,
              vertical: 18.h,
            ),
            hint: Text(
              widget.hintText ?? "",
              style: AppTextStyles.black16w500TextStyle,
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
                      color: Colors.grey,
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
