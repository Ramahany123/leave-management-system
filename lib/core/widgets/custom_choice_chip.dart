import 'package:flutter/material.dart';
import 'package:leave_management_system/core/theme/theme_context_extension.dart';

class CustomChoiceChip extends StatelessWidget {
  final bool isSelected;
  final IconData? icon;
  final String label;
  final VoidCallback onTap;
  const CustomChoiceChip({
    super.key,
    required this.isSelected,
    this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = context.colorScheme;
    return ChoiceChip(
      showCheckmark: false,
      label: Text(
        label,
        style: TextStyle(color: isSelected ? color.onPrimary : color.primary),
      ),
      selected: isSelected,
      avatar: icon != null
          ? Icon(
              icon,
              size: 18,
              color: isSelected ? color.onPrimary : color.primary,
            )
          : null,
      selectedColor: context.colorScheme.primary,
      onSelected: (_) => onTap(),
    );
  }
}
