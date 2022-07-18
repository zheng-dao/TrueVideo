import 'dart:developer';

class DateTimeConverter {
  static DateTime? fromJson(dynamic value) {
    DateTime? result;
    if (value != null) {
      // Map timestamp
      if (value is Map) {
        try {
          final seconds = int.parse(value["_seconds"].toString());
          final nanoseconds = int.parse(value["_nanoseconds"].toString());
          result = DateTime.fromMillisecondsSinceEpoch((seconds * 1000) + (nanoseconds / 1000000).floor());
        } catch (error) {
          log("Error parsing DateTime", error: error);
        }
      }

      // String
      if (value is String) {
        try {
          result = DateTime.parse(value);
        } catch (error) {
          log("Error parsing DateTime", error: error);
        }
      }
    }

    if (result != null) {
      result = result.toLocal();
    }
    return result;
  }
}
