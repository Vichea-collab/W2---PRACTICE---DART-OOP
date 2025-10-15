class MyDuration {
  final int _milliseconds;

  const MyDuration._(this._milliseconds)
      : assert(_milliseconds >= 0, "Duration cannot be negative");

  MyDuration.fromHours(int hours)
      : _milliseconds = hours * 60 * 60 * 1000,
        assert(hours >= 0, "Hours must be non-negative");

  MyDuration.fromMinutes(int minutes)
      : _milliseconds = minutes * 60 * 1000,
        assert(minutes >= 0, "Minutes must be non-negative");

  MyDuration.fromSeconds(int seconds)
      : _milliseconds = seconds * 1000,
        assert(seconds >= 0, "Seconds must be non-negative");

  int get inMilliseconds => _milliseconds;

  MyDuration operator +(MyDuration other) {
    return MyDuration._(_milliseconds + other._milliseconds);
  }

  MyDuration operator -(MyDuration other) {
    if (_milliseconds < other._milliseconds) {
      throw Exception("Resulting duration cannot be negative!");
    }
    return MyDuration._(_milliseconds - other._milliseconds);
  }

  bool operator >(MyDuration other) {
    return _milliseconds > other._milliseconds;
  }

  // Display the duration in a readable format
  @override
  String toString() {
    int totalSeconds = (_milliseconds / 1000).round();
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;
    return '$hours hours, $minutes minutes, $seconds seconds';
  }
}

void main() {
  MyDuration duration1 = MyDuration.fromHours(3); // 3 hours
  MyDuration duration2 = MyDuration.fromMinutes(45); // 45 minutes

  print(duration1 + duration2); // 3 hours, 45 minutes, 0 seconds
  print(duration1 > duration2); // true

  try {
    print(duration2 - duration1); // should throw exception
  } catch (e) {
    print(e); // Exception: Resulting duration cannot be negative!
  }

  var duration3 = MyDuration.fromSeconds(30);
  var total = duration2 + duration3;
  print('Extra test: $total');
}
