class EligibilityOptions {
  EligibilityOptions._();

  static const List<String> userTypes = [
    'Academic',
    'Administrative',
    'Service',
    'All',
  ];

  /// Options + the current value when it isn't in the list, so editing a
  /// rule whose value came from outside this list never crashes the
  /// dropdown (DropdownButtonFormField asserts value ∈ items).
  static List<String> withCurrent(List<String> options, String? current) {
    if (current == null || options.contains(current)) return options;
    return [...options, current];
  }
}
