// Helper function to parse the duration string
import 'dart:developer';

Duration parseDuration(String durationString) {
  final parts = durationString.split(':');
  if (parts.length == 3) {
    log(Duration(
      hours: int.parse(parts[0]),
      minutes: 10,
      seconds: 47,
      milliseconds: 0,
    ).toString());
    return Duration(
      hours: int.parse(parts[0]),
      minutes: int.parse(parts[1]),
      seconds: int.parse(parts[2].split('.').first),
      milliseconds: 0,
    );
  }
  return Duration(seconds: 0);
  // throw FormatException("Invalid duration format", durationString);
}
