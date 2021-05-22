class SuraFormValidator {
  static String? validateField(String value, {String? field}) {
    if (value.isEmpty) {
      return field != null ? "Please input your $field" : "Please input required field";
    }
    return null;
  }

  static String? isNumber(String value, {String? field}) {
    if (value.isEmpty) {
      return field != null ? "Please input your $field" : "Please input required field";
    }
    num? asNumber = num.tryParse(value);
    if (asNumber is num) return null;
    return field != null ? "$field must be a number" : "This field must be a number";
  }
}
