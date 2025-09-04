import 'package:equatable/equatable.dart';

/// Represents duration in minutes with validation
class DurationMinutes extends Equatable {
  final int _value;

  const DurationMinutes._(this._value);

  /// Creates duration from minutes
  factory DurationMinutes.fromMinutes(int minutes) {
    if (minutes < 0) {
      throw ArgumentError('Duration cannot be negative, got $minutes');
    }
    return DurationMinutes._(minutes);
  }

  /// Creates duration from seconds
  factory DurationMinutes.fromSeconds(int seconds) {
    if (seconds < 0) {
      throw ArgumentError('Duration cannot be negative, got $seconds');
    }
    return DurationMinutes._((seconds / 60).round());
  }

  /// Creates duration from hours
  factory DurationMinutes.fromHours(double hours) {
    if (hours < 0) {
      throw ArgumentError('Duration cannot be negative, got $hours');
    }
    return DurationMinutes._((hours * 60).round());
  }

  /// Gets the duration in minutes
  int get minutes => _value;

  /// Gets the duration in seconds
  int get seconds => _value * 60;

  /// Gets the duration in hours
  double get hours => _value / 60;

  /// Gets the duration as a formatted string (e.g., "2h 30m")
  String get formatted {
    if (_value < 60) {
      return '${_value}m';
    }

    final hours = _value ~/ 60;
    final minutes = _value % 60;

    if (minutes == 0) {
      return '${hours}h';
    }

    return '${hours}h ${minutes}m';
  }

  /// Checks if this duration is greater than another
  bool isGreaterThan(DurationMinutes other) => _value > other._value;

  /// Checks if this duration is less than another
  bool isLessThan(DurationMinutes other) => _value < other._value;

  /// Checks if this duration is greater than or equal to another
  bool isGreaterThanOrEqual(DurationMinutes other) => _value >= other._value;

  /// Checks if this duration is less than or equal to another
  bool isLessThanOrEqual(DurationMinutes other) => _value <= other._value;

  /// Adds another duration to this one
  DurationMinutes add(DurationMinutes other) =>
      DurationMinutes._(_value + other._value);

  /// Subtracts another duration from this one
  DurationMinutes subtract(DurationMinutes other) {
    final newValue = _value - other._value;
    if (newValue < 0) {
      return const DurationMinutes._(0);
    }
    return DurationMinutes._(newValue);
  }

  /// Multiplies this duration by a factor
  DurationMinutes multiply(double factor) {
    if (factor < 0) {
      throw ArgumentError('Factor cannot be negative, got $factor');
    }
    return DurationMinutes._((_value * factor).round());
  }

  /// Divides this duration by a factor
  DurationMinutes divide(double factor) {
    if (factor <= 0) {
      throw ArgumentError('Factor must be positive, got $factor');
    }
    return DurationMinutes._((_value / factor).round());
  }

  @override
  List<Object?> get props => [_value];

  @override
  String toString() => formatted;

  /// Common duration values
  static const DurationMinutes zero = DurationMinutes._(0);
  static const DurationMinutes fiveMinutes = DurationMinutes._(5);
  static const DurationMinutes fifteenMinutes = DurationMinutes._(15);
  static const DurationMinutes thirtyMinutes = DurationMinutes._(30);
  static const DurationMinutes oneHour = DurationMinutes._(60);
  static const DurationMinutes twoHours = DurationMinutes._(120);
}
