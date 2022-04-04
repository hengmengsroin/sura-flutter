extension SuraStringExtension on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1, length);
  }
}

extension SuraNullableStringExtension on String? {
  bool get isNullOrEmpty => this == null || (this?.isEmpty ?? true);
}
