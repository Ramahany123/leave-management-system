import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../admin_org_structure/logic/cubit/colleges_cubit.dart';

class CollegeDropDown extends StatelessWidget {
  final bool isDisabled;
  final int? selectedCollegeId;
  final void Function(int?)? onChanged;
  const CollegeDropDown({
    super.key,
    required this.isDisabled,
    required this.selectedCollegeId,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollegesCubit, CollegesState>(
      builder: (context, state) {
        List<DropdownMenuItem<int>>? items;
        bool isEnabled = false;
        Widget? suffixIcon;
        if (state is CollegesLoading || state is CollegesInitial) {
          suffixIcon = SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(),
          );
        } else if (state is CollegesSuccess) {
          isEnabled = true;
          items = state.colleges
              .map(
                (college) => DropdownMenuItem<int>(
                  value: college.collegeId,
                  child: Text(college.collegeName),
                ),
              )
              .toList();
        } else if (state is CollegesError) {
          isEnabled = false;
          suffixIcon = IconButton(
            onPressed: () {
              context.read<CollegesCubit>().getAllColleges();
            },
            icon: Icon(Icons.refresh),
          );
        }
        return DropdownButtonFormField<int>(
          hint: Text("Colleges"),
          validator: AppValidators.validateRequired<int>,
          initialValue: selectedCollegeId,
          items: items,
          onChanged: isEnabled && !isDisabled ? onChanged : null,
          decoration: InputDecoration(suffixIcon: suffixIcon),
        );
      },
    );
  }
}
