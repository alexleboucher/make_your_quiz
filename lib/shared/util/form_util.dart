abstract class FormUtil {
  static bool isNullOrEmpty(String? value, {bool trim = true}) {
    if (value == null) {
      return true;
    }
    final val = trim ? value.trim() : value;
    return val.isEmpty;
  }
}
