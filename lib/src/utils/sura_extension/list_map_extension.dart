extension SuraListExtension on List {
  List<T> filter<T extends Object>(bool Function(T) test) {
    List<T> filtered = [];
    for (var data in this) {
      bool passed = test(data);
      if (passed) filtered.add(data);
    }
    return filtered;
  }
}

extension SuraMapExtension on Map {
  void addIfNotNull(dynamic key, dynamic data) {
    if (data != null) putIfAbsent(key, () => data);
  }

  getIfExist(dynamic key) {
    if (keys.contains(key)) {
      return this[key];
    }
    return null;
  }
}
