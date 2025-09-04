import 'package:equatable/equatable.dart';

/// Represents speed in kilometers per hour with validation
class SpeedKmh extends Equatable {
  final double _value;

  const SpeedKmh._(this._value);

  /// Creates speed from kilometers per hour
  factory SpeedKmh.fromKmh(double kmh) {
    if (kmh < 0) {
      throw ArgumentError('Speed cannot be negative, got $kmh');
    }
    return SpeedKmh._(kmh);
  }

  /// Creates speed from meters per second
  factory SpeedKmh.fromMs(double ms) {
    if (ms < 0) {
      throw ArgumentError('Speed cannot be negative, got $ms');
    }
    return SpeedKmh._(ms * 3.6);
  }

  /// Gets the speed in kilometers per hour
  double get kmh => _value;

  /// Gets the speed in meters per second
  double get ms => _value / 3.6;

  /// Gets the speed in miles per hour
  double get mph => _value * 0.621371;

  /// Checks if this speed is greater than another
  bool isGreaterThan(SpeedKmh other) => _value > other._value;

  /// Checks if this speed is less than another
  bool isLessThan(SpeedKmh other) => _value < other._value;

  /// Checks if this speed is greater than or equal to another
  bool isGreaterThanOrEqual(SpeedKmh other) => _value >= other._value;

  /// Checks if this speed is less than or equal to another
  bool isLessThanOrEqual(SpeedKmh other) => _value <= other._value;

  /// Multiplies this speed by a factor
  SpeedKmh multiply(double factor) {
    if (factor < 0) {
      throw ArgumentError('Factor cannot be negative, got $factor');
    }
    return SpeedKmh._(_value * factor);
  }

  /// Divides this speed by a factor
  SpeedKmh divide(double factor) {
    if (factor <= 0) {
      throw ArgumentError('Factor must be positive, got $factor');
    }
    return SpeedKmh._(_value / factor);
  }

  @override
  List<Object?> get props => [_value];

  @override
  String toString() => '${_value.toStringAsFixed(1)} km/h';

  /// Common speed values
  static const SpeedKmh zero = SpeedKmh._(0);
  static const SpeedKmh citySpeed = SpeedKmh._(50);
  static const SpeedKmh highwaySpeed = SpeedKmh._(100);
  static const SpeedKmh maxSpeed = SpeedKmh._(130);
}
