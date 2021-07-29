String format(dynamic value) {
  String rounded = '';
  if (value is int) {
    rounded = value.toString();
  } else if (value is double) {
    rounded = value.toStringAsFixed(3);
  }
  return value < 10 ? '0' + rounded : rounded;
}

String hours(int duration) {
  int value = (duration / (24 * 60 * 100) % 86400).floor();
  return format(value);
}

String minutes(int duration) {
  int value = ((duration / (60 * 100) % 3600) % 60).floor();
  return format(value);
}

String seconds(int duration) {
  double value = (duration / 100 % 60);
  return format(value);
}

String elapsedTime(duration) {
  return hours(duration) + ':' + minutes(duration) + ':' + seconds(duration);
}