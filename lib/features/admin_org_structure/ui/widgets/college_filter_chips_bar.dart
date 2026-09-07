import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/widgets/custom_choice_chip.dart';
import 'package:leave_management_system/features/admin_org_structure/logic/cubit/colleges_cubit.dart';

class CollegeFilterChipsBar extends StatelessWidget {
  final int? selectedCollegeId;
  final ValueChanged<int?> onCollegeSelected;
  const CollegeFilterChipsBar({
    super.key,
    this.selectedCollegeId,
    required this.onCollegeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollegesCubit, CollegesState>(
      builder: (context, state) {
        if (state is! CollegesSuccess) {
          return const SizedBox.shrink(); //TODO: use shimmer instead
        }

        final colleges = state.colleges;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(end: 8.w),
                child: CustomChoiceChip(
                  isSelected: selectedCollegeId == null,
                  label: "All",
                  onTap: () => onCollegeSelected(null),
                ),
              ),
              ...colleges.map(
                (college) => Padding(
                  padding: EdgeInsetsDirectional.only(end: 8.w),
                  child: CustomChoiceChip(
                    isSelected: selectedCollegeId == college.collegeId,
                    label: college.collegeName,
                    onTap: () => onCollegeSelected(college.collegeId),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
