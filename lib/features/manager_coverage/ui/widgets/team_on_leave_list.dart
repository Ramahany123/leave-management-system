import 'package:flutter/widgets.dart';
import 'package:leave_management_system/features/manager_coverage/ui/widgets/team_member_on_leave_card.dart';

import '../../data/models/team_on_leave_model.dart';

class TeamOnLeaveList extends StatelessWidget {
  final List<TeamMemberOnLeave> membersOnLeave;
  const TeamOnLeaveList({super.key, required this.membersOnLeave});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      clipBehavior: Clip.none,
      itemCount: membersOnLeave.length,
      itemBuilder: (context, index) {
        final member = membersOnLeave[index];
        return TeamMemberOnLeaveCard(teamMemberOnLeave: member);
      },
    );
  }
}
