String? shift(List<String> elements) {
  if (elements.isEmpty) return null;
  return elements.removeAt(0);
}

Map<String, dynamic> merge(
  Map<String, dynamic>? obj,
  Map<String, dynamic> defaults,
) {
  if (obj == null) {
    return defaults;
  }
  defaults.forEach((key, val) => obj.putIfAbsent(key, () => val));
  return obj;
}
