import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/app_colors.dart';

class SettingsGroup extends StatelessWidget {
  final List<Widget> children;
  const SettingsGroup({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(children: _buildChildrenWithDividers()),
    );
  }

  List<Widget> _buildChildrenWithDividers() {
    List<Widget> result = [];
    for (int i = 0; i < children.length; i++) {
      result.add(children[i]);
      if (i < children.length - 1) {
        result.add(_buildDivider());
      }
    }
    return result;
  }
}

Widget _buildDivider() {
  return Divider(height: 1.h, thickness: 1.h, color: AppColors.cardBorderColor);
}
