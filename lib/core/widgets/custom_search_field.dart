import 'package:flutter/material.dart';
import 'package:leave_management_system/core/widgets/custom_text_field.dart';

class CustomSearchField extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final String hintText;
  const CustomSearchField({
    super.key,
    this.onChanged,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, textValue, child) {
        return CustomTextField(
          controller: controller,
          hintText: hintText,
          prefixIcon: Icon(Icons.search),
          onChanged: onChanged,
          suffixIcon: textValue.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    controller.clear();
                    if (onChanged != null) onChanged!("");
                  },
                  icon: Icon(Icons.clear),
                )
              : null,
        );
      },
    );
  }
}
