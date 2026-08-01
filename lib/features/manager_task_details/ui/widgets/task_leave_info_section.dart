import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management_system/core/extensions/context_extensions.dart';
import 'package:leave_management_system/core/widgets/attachments_file_card.dart';
import 'package:leave_management_system/core/widgets/info_section.dart';
import 'package:leave_management_system/core/widgets/key_value_row_widget.dart';

import '../../data/models/task_detail_model.dart';

class TaskLeaveInfoSection extends StatelessWidget {
  final TaskDetailsModel taskDetails;
  const TaskLeaveInfoSection({super.key, required this.taskDetails});

  @override
  Widget build(BuildContext context) {
    final request = taskDetails.request;
    return Column(
      children: [
        InfoSection(
          title: "Leave Info",
          children: [
            KeyValueRow(label: "Type: ", value: request.type),
            KeyValueRow(label: "Start date: ", value: request.startDate),
            KeyValueRow(label: "End date: ", value: request.endDate),
            KeyValueRow(label: "Reason: ", value: request.reason),
          ],
        ),
        if (request.delegate != null) ...[
          SizedBox(height: 24.h),
          InfoSection(
            title: "Delegation Details",
            children: [
              KeyValueRow(label: "Delegate: ", value: request.delegate!.name),
              KeyValueRow(label: "Email: ", value: request.delegate!.email),
            ],
          ),
        ],

        if (request.attachments.isNotEmpty) ...[
          SizedBox(height: 24.h),
          InfoSection(
            title: "Attachments",
            children: request.attachments.map((attachment) {
              return AttachmentsFileCard(
                fileName: attachment.fileName,
                onView: () async {
                  await context.openAttachemnt(attachment.filePath);
                },
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
