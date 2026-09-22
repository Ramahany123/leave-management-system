import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leave_management_system/core/utils/animated_snack_dialogue.dart';
import 'package:leave_management_system/core/utils/app_dialogs.dart';
import 'package:leave_management_system/core/widgets/custom_search_field.dart';
import 'package:leave_management_system/core/widgets/empty_state_widget.dart';
import 'package:leave_management_system/core/widgets/general_error_widget.dart';
import 'package:leave_management_system/features/admin_user_management/logic/cubit/admin_users_cubit.dart';
import 'package:leave_management_system/features/admin_user_management/ui/widgets/admin_user_card.dart';
import 'package:leave_management_system/features/admin_user_management/ui/widgets/admin_users_shimmer.dart';

import '../../../../core/routes/app_routes.dart';

class AdminUserManagementScreen extends StatefulWidget {
  const AdminUserManagementScreen({super.key});

  @override
  State<AdminUserManagementScreen> createState() =>
      _AdminUserManagementScreenState();
}

class _AdminUserManagementScreenState extends State<AdminUserManagementScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<AdminUsersCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text("Staff & Faculty Directory")),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              CustomSearchField(
                controller: _searchController,
                hintText: "Search by name, email, or role...",
                onChanged: (val) {
                  userCubit.searchUsers(val);
                },
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: BlocConsumer<AdminUsersCubit, AdminUsersState>(
                  listener: (BuildContext context, AdminUsersState state) {
                    if (state.deleteUserFailure != null) {
                      showAnimatedSnakDialogue(
                        context,
                        message: state.deleteUserFailure?.message,
                        type: AnimatedSnackBarType.error,
                      );
                      userCubit.clearDeleteUserFailure();
                    }
                    if (state.usersStatus == UsersStatus.refreshFailure &&
                        state.getAllUsersFailure != null) {
                      showAnimatedSnakDialogue(
                        context,
                        message: state.getAllUsersFailure!.message,
                        type: AnimatedSnackBarType.error,
                      );
                      userCubit.clearRefreshFailure();
                    }
                  },
                  builder: (context, state) {
                    if (state.usersStatus == UsersStatus.loading) {
                      return AdminUsersShimmer();
                    } else if (state.usersStatus == UsersStatus.failure) {
                      return GeneralErrorWidget(
                        message: state.getAllUsersFailure!.message,
                        onRetry: userCubit.getAllUsers,
                      );
                    } else if (state.users.isEmpty &&
                        state.searchQuery.isEmpty &&
                        state.usersStatus == UsersStatus.success) {
                      return EmptyStateWidget(message: "No users found");
                    } else if (state.users.isEmpty &&
                        state.searchQuery.isNotEmpty &&
                        state.usersStatus == UsersStatus.success) {
                      return EmptyStateWidget(
                        message: "No users match your search",
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: userCubit.refreshUsers,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          final user = state.users[index];
                          return AdminUserCard(
                            user: user,
                            isDeleting: state.deletingUserId == user.userId,
                            onDelete: () async {
                              final bool? isDeleted =
                                  await AppDialogs.showDeleteConfirmationDialog(
                                    context,
                                    message:
                                        "Are You Sure You Want To Delete This User?",
                                    confirmText: "Confirm",
                                    cancelText: "Cancel",
                                  );
                              if (isDeleted == true) {
                                userCubit.deleteUser(user.userId);
                              }
                            },
                            onTap: () {
                              AppDialogs.showAdminUserDetailsSheet(
                                context,
                                user,
                              );
                            },
                            onEdit: () async {
                              final bool? isUpdated = await context.push<bool>(
                                AppRoutes.adminUserManagementFormScreen,
                                extra: user,
                              );
                              if (isUpdated == true && context.mounted) {
                                showAnimatedSnakDialogue(
                                  context,
                                  message: "User Updated Successfully",
                                );
                                userCubit.refreshUsers();
                              }
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add User",
        onPressed: () async {
          final bool? isCreated = await context.push<bool>(
            AppRoutes.adminUserManagementFormScreen,
          );
          if (isCreated == true && context.mounted) {
            showAnimatedSnakDialogue(
              context,
              message: "User Created Successfully",
            );
            userCubit.refreshUsers();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
