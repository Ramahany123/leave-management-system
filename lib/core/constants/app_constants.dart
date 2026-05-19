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
}
