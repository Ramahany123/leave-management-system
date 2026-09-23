import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/constants/app_constants.dart';
import 'package:leave_management_system/core/utils/animated_snack_dialogue.dart';
import 'package:leave_management_system/core/utils/date_extension.dart';
import 'package:leave_management_system/core/utils/date_picker_helper.dart';
import 'package:leave_management_system/core/widgets/primary_button_widget.dart';
import 'package:leave_management_system/core/widgets/section_header_widget.dart';
import 'package:leave_management_system/features/admin_org_structure/logic/cubit/departments_cubit.dart';
import 'package:leave_management_system/features/admin_user_management/data/models/admin_user_model.dart';
import 'package:leave_management_system/features/admin_user_management/data/models/update_user_request_model.dart';
import 'package:leave_management_system/features/admin_user_management/logic/cubit/admin_user_form_cubit.dart';
import 'package:leave_management_system/features/admin_user_management/ui/widgets/admin_user_basic_info_section.dart';
import 'package:leave_management_system/features/admin_user_management/ui/widgets/admin_user_edit_section.dart';
import 'package:leave_management_system/features/admin_user_management/ui/widgets/admin_user_organization_section.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/theme/theme_context_extension.dart';
import '../../data/models/create_user_request_model.dart';

class AdminUserManagementForm extends StatefulWidget {
  final AdminUserModel? user;
  const AdminUserManagementForm({super.key, this.user});

  @override
  State<AdminUserManagementForm> createState() =>
      _AdminUserManagementFormState();
}

class _AdminUserManagementFormState extends State<AdminUserManagementForm> {
  bool get isEditingMode => widget.user != null;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _ssnController;
  late final TextEditingController _jobTitleController;
  late final TextEditingController _workplaceController;
  late final TextEditingController _hireDateController;
  late final TextEditingController _dateOfBirthController;
  late final TextEditingController _phoneController;
  final List<String> _gender = ["Male", "Female"];
  String? _selectedGender;
  int? _selectedCollegeId;
  int? _selectedDepartmentId;
  DateTime? _selectedHireDate;
  DateTime? _selectedDateOfBirth;
  String? _selectedRole;
  UserType? _selectedUserType;
  late bool _isActive;
  void _initializeForm() {
    final user = widget.user;
    _nameController = TextEditingController(text: user?.name ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _ssnController = TextEditingController(text: user?.ssn ?? '');
    _jobTitleController = TextEditingController(text: user?.jobTitle ?? '');
    _workplaceController = TextEditingController(text: user?.workplace ?? '');
    _hireDateController = TextEditingController(
      text: user?.hireDate.toReadableDate ?? '',
    );
    _dateOfBirthController = TextEditingController(
      text: user?.dateOfBirth.toReadableDate ?? '',
    );
    _phoneController = TextEditingController(text: user?.phone ?? "");
    _selectedGender = user?.gender;
    _selectedCollegeId = user?.collegeId;
    _selectedDepartmentId = user?.departmentId;
    _selectedHireDate = user?.hireDate;
    _selectedDateOfBirth = user?.dateOfBirth;
    _selectedRole = user?.role ?? UserRoles.employeeRole;
    _selectedUserType = user != null
        ? UserType.fromRawValue(user.userType)
        : null;
    _isActive = user?.isActive ?? false;
  }

  Future<void> _pickHireDate() async {
    final DateTime now = DateTime.now();
    final picked = await DatePickerHelper.pickDate(
      context,
      initialDate: _selectedHireDate,
      firstDate: DateTime(now.year - 70),
      lastDate: DateTime(now.year + 1),
      helpText: "Pick Hire Date",
    );
    if (picked != null && picked != _selectedHireDate && mounted) {
      setState(() {
        _selectedHireDate = picked;
        _hireDateController.text = picked.toReadableDate;
      });
    }
  }

  Future<void> _pickDateOfBirth() async {
    final now = DateTime.now();
    final picked = await DatePickerHelper.pickDate(
      context,
      initialDate: _selectedDateOfBirth ?? DateTime(now.year - 18),
      firstDate: DateTime(now.year - 80),
      lastDate: DateTime(now.year - 18),
      helpText: "Select Date Of Birth",
    );
    if (picked != null && picked != _selectedDateOfBirth && mounted) {
      setState(() {
        _selectedDateOfBirth = picked;
        _dateOfBirthController.text = picked.toReadableDate;
      });
    }
  }

  void _loadDeptartments() {
    final collegeId = widget.user?.collegeId;
    if (collegeId != null) {
      context.read<DepartmentsCubit>().filterbyCollegeId(collegeId);
    }
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      if (isEditingMode) {
        final request = UpdateUserRequestModel(
          name: _nameController.text,
          email: _emailController.text,
          ssn: _ssnController.text,
          userType: _selectedUserType!.rawValue,
          hireDate: _selectedHireDate,
          dateOfBirth: _selectedDateOfBirth,
          departmentId: _selectedDepartmentId,
          collegeId: _selectedCollegeId,
          gender: _selectedGender,
          role: _selectedRole,
          phone: _phoneController.text.isEmpty ? null : _phoneController.text,
          isActive: _isActive,
          jobTitle: _jobTitleController.text.isEmpty
              ? null
              : _jobTitleController.text,
          workplace: _workplaceController.text.isEmpty
              ? null
              : _workplaceController.text,
        );
        context.read<AdminUserFormCubit>().updateUser(
          request,
          widget.user!.userId,
        );
      } else {
        final request = CreateUserRequestModel(
          name: _nameController.text,
          email: _emailController.text,
          ssn: _ssnController.text,
          userType: _selectedUserType!.rawValue,
          hireDate: _selectedHireDate!,
          dateOfBirth: _selectedDateOfBirth!,
          departmentId: _selectedDepartmentId!,
          collegeId: _selectedCollegeId!,
          gender: _selectedGender!,
          role: _selectedRole!,
          jobTitle: _jobTitleController.text.isEmpty
              ? null
              : _jobTitleController.text,
          workplace: _workplaceController.text.isEmpty
              ? null
              : _workplaceController.text,
        );
        context.read<AdminUserFormCubit>().createUser(request);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeForm();
    _loadDeptartments();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ssnController.dispose();
    _jobTitleController.dispose();
    _workplaceController.dispose();
    _hireDateController.dispose();
    _dateOfBirthController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditingMode ? "Edit User" : "Add New User",
          style: context.textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<AdminUserFormCubit, AdminUserFormState>(
          listener: (context, state) {
            if (state is AdminUserFormSuccess) {
              context.pop(true);
            } else if (state is AdminUserFormError) {
              showAnimatedSnakDialogue(
                context,
                message: state.failure.message,
                type: AnimatedSnackBarType.error,
              );
            }
          },
          builder: (context, state) {
            final bool isLoading = state is AdminUserFormLoading;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 24.h,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionHeaderWidget(
                            title: "Personal Information",
                            icon: Icons.person_outline_rounded,
                          ),
                          SizedBox(height: 14.h),

                          AdminUserBasicInfoSection(
                            nameController: _nameController,
                            emailController: _emailController,
                            ssnController: _ssnController,
                            jobTitleController: _jobTitleController,
                            workplaceController: _workplaceController,
                            isDisabled: isLoading,
                          ),

                          SizedBox(height: 24.h),

                          const SectionHeaderWidget(
                            title: "Organization & Placement",
                            icon: Icons.business_outlined,
                          ),
                          SizedBox(height: 14.h),

                          AdminUserOrganizationSection(
                            selectedGender: _selectedGender,
                            selectedCollegeId: _selectedCollegeId,
                            selectedDepartmentId: _selectedDepartmentId,
                            selectedHireDate: _selectedHireDate,
                            selectedDateOfBirth: _selectedDateOfBirth,
                            selectedRole: _selectedRole,
                            selectedUserType: _selectedUserType,
                            hireDateController: _hireDateController,
                            dateOfBirthController: _dateOfBirthController,
                            onGenderChanged: (newValue) {
                              setState(() {
                                _selectedGender = newValue;
                              });
                            },
                            onCollegeChanged: (newValue) {
                              setState(() {
                                _selectedDepartmentId = null;
                                _selectedCollegeId = newValue;
                              });

                              context
                                  .read<DepartmentsCubit>()
                                  .filterbyCollegeId(newValue);
                            },
                            onDepartmentChanged: (newValue) {
                              setState(() {
                                _selectedDepartmentId = newValue;
                              });
                            },
                            onRoleChanged: (newValue) {
                              setState(() {
                                _selectedRole = newValue;
                              });
                            },
                            onUserTypeChanged: (newValue) {
                              setState(() {
                                _selectedUserType = newValue;
                              });
                            },
                            onHireDateTap: _pickHireDate,
                            onDateOfBirthTap: _pickDateOfBirth,
                            isDisabled: isLoading,
                            gender: _gender,
                          ),

                          SizedBox(height: 24.h),

                          if (isEditingMode) ...[
                            const SectionHeaderWidget(
                              title: "Account Settings",
                              icon: Icons.manage_accounts_outlined,
                            ),
                            SizedBox(height: 14.h),

                            AdminUserEditSection(
                              phoneController: _phoneController,
                              isActive: _isActive,
                              onActiveChanged: (newValue) {
                                setState(() {
                                  _isActive = newValue;
                                });
                              },
                              isDisabled: isLoading,
                            ),

                            SizedBox(height: 24.h),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),

                // Sticky action area
                Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 16.h),
                  child: SizedBox(
                    width: double.infinity,
                    child: PrimaryButtonWidget(
                      isLoading: isLoading,
                      onPressed: _onSave,
                      child: Text(
                        isEditingMode ? "Save Changes" : "Create User",
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
