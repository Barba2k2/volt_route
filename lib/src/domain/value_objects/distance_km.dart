import 'package:equatable/equatable.dart';

/// Represents a distance in kilometers with validation
class DistanceKm extends Equatable {
  final double _value;

  const DistanceKm._(this._value);

  /// Creates a distance from kilometers
  factory DistanceKm.fromKm(double kilometers) {
    if (kilometers < 0) {
      throw ArgumentError('Distance cannot be negative, got $kilometers');
    }
    return DistanceKm._(kilometers);
  }

  /// Creates a distance from meters
  factory DistanceKm.fromMeters(double meters) {
    if (meters < 0) {
      throw ArgumentError('Distance cannot be negative, got $meters');
    }
    return DistanceKm._(meters / 1000);
  }

  /// Gets the distance in kilometers
  double get kilometers => _value;

  /// Gets the distance in meters
  double get meters => _value * 1000;

  /// Gets the distance in miles
  double get miles => _value * 0.621371;

  /// Checks if this distance is greater than another
  bool isGreaterThan(DistanceKm other) => _value > other._value;

  /// Checks if this distance is less than another
  bool isLessThan(DistanceKm other) => _value < other._value;

  /// Checks if this distance is greater than or equal to another
  bool isGreaterThanOrEqual(DistanceKm other) => _value >= other._value;

  /// Checks if this distance is less than or equal to another
  bool isLessThanOrEqual(DistanceKm other) => _value <= other._value;

  /// Adds another distance to this one
  DistanceKm add(DistanceKm other) => DistanceKm._(_value + other._value);

  /// Subtracts another distance from this one
  DistanceKm subtract(DistanceKm other) {
    final newValue = _value - other._value;
    if (newValue < 0) {
      return const DistanceKm._(0);
    }
    return DistanceKm._(newValue);
  }

  /// Multiplies this distance by a factor
  DistanceKm multiply(double factor) {
    if (factor < 0) {
      throw ArgumentError('Factor cannot be negative, got $factor');
    }
    return DistanceKm._(_value * factor);
  }

  /// Divides this distance by a factor
  DistanceKm divide(double factor) {
    if (factor <= 0) {
      throw ArgumentError('Factor must be positive, got $factor');
    }
    return DistanceKm._(_value / factor);
  }

  @override
  List<Object?> get props => [_value];

  @override
  String toString() => '${_value.toStringAsFixed(2)} km';

  /// Common distance values
  static const DistanceKm zero = DistanceKm._(0);
  static const DistanceKm oneKm = DistanceKm._(1);
  static const DistanceKm tenKm = DistanceKm._(10);
  static const DistanceKm hundredKm = DistanceKm._(100);
  static const DistanceKm thousandKm = DistanceKm._(1000);
}
