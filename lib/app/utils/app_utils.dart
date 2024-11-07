class AppUtils {
  AppUtils._();

  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String seconds = twoDigits(duration.inSeconds.remainder(60).abs());
    if (duration.isNegative) {
      return '-$minutes:$seconds';
    } else {
      return '$minutes:$seconds';
    }
  }
}
