class LeaveTypeOptions {
  LeaveTypeOptions._();

  static const List<String> categorySuggestions = [
    'Annual',
    'Religious',
    'Academic',
  ];

  static const List<String> balanceTypes = ['fixed', 'calculated'];

  static const List<String> calculationMethods = ['Fixed', 'Egypt_Labor_Law'];

  static const List<String> genderPolicies = ['All', 'Male', 'Female'];

  static const List<String> approverRoles = [
    'Head_of_Department',
    'Dean',
    'President',
    'HR_Admin',
    'Department_Council',
    'Faculty_Council',
    'University_Council',
  ];

  static List<String> withCurrent(List<String> options, String? current) {
    if (current == null || options.contains(current)) return options;
    return [...options, current];
  }

  static String displayLabel(String rawValue) => rawValue.replaceAll('_', ' ');
}
