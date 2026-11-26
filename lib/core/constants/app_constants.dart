import 'enums.dart';

class AppImages {
  static const String universityLogo = "assets/images/Hurghada-University.png";
  static const String loadingLottie = "assets/lottie/loadingLottie.json";
}

class CacheKeys {
  static const String userToken = "userToken";
  static const String isDarkMode = "isDarkMode";
  static const String language = "language";
  static const String authStatus = "authStatus";
  static const String userRole = "userRole";
  static const String userName = "userName";
}

class UserRoles {
  static const managerRoles = ["Manager", "Dean", "President"];
  static const employeeRole = "Employee";
  static const adminRole = "HR_Admin";
  static const List<String> allRoles = [
    ...managerRoles,
    employeeRole,
    adminRole,
  ];
}

class PersonaAreas {
  const PersonaAreas._();

  //put primary area as index [0]
  static const List<AppArea> _employeeOnly = <AppArea>[AppArea.employee];
  static const List<AppArea> _managerAndEmployee = <AppArea>[
    AppArea.manager,
    AppArea.employee,
  ];
  static const List<AppArea> _adminAndEmployee = <AppArea>[
    AppArea.admin,
    AppArea.employee,
  ];
  static const List<AppArea> _none = <AppArea>[];

  static List<AppArea> areasFor(String role) {
    switch (role) {
      case UserRoles.employeeRole:
        return _employeeOnly;
      case UserRoles.adminRole:
        return _adminAndEmployee;
      // Managers, Deansand Presidents share one policy; anything else has none.
      default:
        return UserRoles.managerRoles.contains(role)
            ? _managerAndEmployee
            : _none;
    }
  }

  static AppArea? primaryAreaFor(String role) {
    final List<AppArea> areas = areasFor(role);
    return areas.isEmpty ? null : areas.first;
  }
}

//TODO: lozalize text
class RequestStatues {
  static const String all = "All";
  static const String pending = "Pending";
  static const String approved = "Approved";
  static const String rejected = "Rejected";
  static const String cancelled = "Cancelled";

  static const List<String> statues = [
    all,
    pending,
    approved,
    rejected,
    cancelled,
  ];
  static const List<String> overrideStatuses = [approved, rejected, cancelled];
}
