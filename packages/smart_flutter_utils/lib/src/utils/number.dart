part of 'utils.dart';

extension SizeNumber on num {
  double get half => this * 0.5;

  double get oneHalf => this * 1.5;

  double get twice => this * 2;

  double get sizeToCupertinoRadius => this * 0.2237;

  Radius get radiusCircular => Radius.circular(toDouble());

  BorderRadius get borderRadiusCircular => BorderRadius.circular(toDouble());

  RoundedRectangleBorder roundedRectangleBorder([BorderSide? side]) =>
      RoundedRectangleBorder(
        borderRadius: borderRadiusCircular,
        side: side ?? BorderSide.none,
      );

  BoxDecoration radiusToBoxDecoration({Color? color, bool border = false}) =>
      BoxDecoration(
        borderRadius: borderRadiusCircular,
        border: border
            ? color != null && !color.isDark
                ? Border.all(color: color.darker, width: 0.2)
                : null
            : null,
        color: color,
      );
}

extension RepeatTaskNumber on num {
  void repeatsFor(void Function() apply) {
    if (this > 0) {
      for (int i = 0; i < this; i++) {
        apply();
      }
    }
  }

  void repeatsForIndexed(void Function(int i) apply) {
    if (this > 0) {
      for (int i = 0; i < this; i++) {
        apply(i);
      }
    }
  }
}

/// Easy way to make Durations from numbers.
///
/// Sample:
/// ```
/// print(1.seconds + 200.milliseconds);
/// print(1.hours + 30.minutes);
/// print(1.5.hours);
///```
extension DurationNumber on num {
  Duration get milliseconds => Duration(microseconds: (this * 1000).round());

  Duration get seconds => Duration(milliseconds: (this * 1000).round());

  Duration get minutes =>
      Duration(seconds: (this * Duration.secondsPerMinute).round());

  Duration get hours =>
      Duration(minutes: (this * Duration.minutesPerHour).round());

  Duration get days => Duration(hours: (this * Duration.hoursPerDay).round());
}

extension RangeNumber on num {
  bool isRange(num start, num end) => this >= start && this <= end;

  bool isInRange(num start, num end) => this > start && this < end;
}

extension NumArithmetic on num {
  double? divideBy(double? value) => value == null ? null : this / value;

  double? multiplyBy(double? value) => value == null ? null : this * value;

  double percent(double value) => this * (value / 100);

  double get fifty => percent(50);

  double get fourty => percent(40);

  double get third => percent(33.33);

  double get quarter => percent(25);

  double get fifth => percent(20);
}
