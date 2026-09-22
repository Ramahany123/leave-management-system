import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../admin_org_structure/logic/cubit/departments_cubit.dart';

class DepartmentDropDown extends StatelessWidget {
  final int? selectedCollegeId;
  final int? selectedDepartmentId;
  final void Function(int?)? onChanged;
  final bool isDisabled;
  const DepartmentDropDown({
    super.key,
    required this.selectedCollegeId,
    required this.selectedDepartmentId,
    required this.isDisabled,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DepartmentsCubit, DepartmentsState>(
      builder: (context, state) {
        List<DropdownMenuItem<int>>? items;
        bool isEnabled = false;
        Widget? suffixIcon;
        String hint = "Select a college first";
        if (state is DepartmentsLoading) {
          hint = "Loading departments...";
        } else if (state is DepartmentsSuccess) {
          hint = "Department";
          isEnabled = true;
          items = state.departments
              .map(
                (dept) => DropdownMenuItem<int>(
                  value: dept.departmentId,
                  child: Text(dept.departmentName),
                ),
              )
              .toList();
        } else if (state is DepartmentsError) {
          hint = "Failed to Get Deparmtents";
          isEnabled = false;
          suffixIcon = IconButton(
            onPressed: () {
              context.read<DepartmentsCubit>().filterbyCollegeId(
                selectedCollegeId,
              );
            },
            icon: Icon(Icons.refresh),
          );
        }
        return DropdownButtonFormField<int>(
          initialValue: selectedDepartmentId,
          hint: Text(hint),
          items: items,
          onChanged: isEnabled && !isDisabled ? onChanged : null,
          decoration: InputDecoration(suffixIcon: suffixIcon),
        );
      },
    );
  }
}
