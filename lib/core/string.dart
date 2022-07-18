class CustomStringUtils {
  static String toCapitalized(String text) => text.isNotEmpty ? '${text[0].toUpperCase()}${text.substring(1).toLowerCase()}' : '';

  static String toTitleCase(String text) => text.replaceAll(RegExp(' +'), ' ').split(' ').map((str) => toCapitalized(str)).join(' ');
}

extension CustomStringExtension on String {
  String toCapitalize() => CustomStringUtils.toCapitalized(this);

  String toTitleCase() => CustomStringUtils.toTitleCase(this);
}
