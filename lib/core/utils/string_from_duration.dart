String formatDuration(Duration duration) {
  // Get the total number of minutes and seconds from the Duration
  int minutes = duration.inMinutes;
  int seconds = duration.inSeconds % 60;

  // Format minutes and seconds with leading zeros if needed
  String minutesStr = minutes.toString().padLeft(2, '0');
  String secondsStr = seconds.toString().padLeft(2, '0');

  // Combine minutes and seconds into MM:SS format
  return "$minutesStr:$secondsStr";
}
