import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

class SettingsGroup extends StatelessWidget {
  final List<Widget> children;
  const SettingsGroup({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(children: _buildChildrenWithDividers(context)),
    );
  }

  List<Widget> _buildChildrenWithDividers(BuildContext context) {
    List<Widget> result = [];
    for (int i = 0; i < children.length; i++) {
      result.add(children[i]);
      if (i < children.length - 1) {
        result.add(_buildDivider(context));
      }
    }
    return result;
  }
}

Widget _buildDivider(BuildContext context) {
  return Divider(height: 1.h, thickness: 1.h, color: context.colorScheme.outline);
}
