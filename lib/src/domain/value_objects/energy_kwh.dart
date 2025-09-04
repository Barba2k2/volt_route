import 'package:equatable/equatable.dart';

/// Represents energy in kilowatt-hours with validation
class EnergyKwh extends Equatable {
  final double _value;

  const EnergyKwh._(this._value);

  /// Creates energy from kilowatt-hours
  factory EnergyKwh.fromKwh(double kilowattHours) {
    if (kilowattHours < 0) {
      throw ArgumentError('Energy cannot be negative, got $kilowattHours');
    }
    return EnergyKwh._(kilowattHours);
  }

  /// Creates energy from watt-hours
  factory EnergyKwh.fromWh(double wattHours) {
    if (wattHours < 0) {
      throw ArgumentError('Energy cannot be negative, got $wattHours');
    }
    return EnergyKwh._(wattHours / 1000);
  }

  /// Gets the energy in kilowatt-hours
  double get kilowattHours => _value;

  /// Gets the energy in watt-hours
  double get wattHours => _value * 1000;

  /// Checks if this energy is greater than another
  bool isGreaterThan(EnergyKwh other) => _value > other._value;

  /// Checks if this energy is less than another
  bool isLessThan(EnergyKwh other) => _value < other._value;

  /// Checks if this energy is greater than or equal to another
  bool isGreaterThanOrEqual(EnergyKwh other) => _value >= other._value;

  /// Checks if this energy is less than or equal to another
  bool isLessThanOrEqual(EnergyKwh other) => _value <= other._value;

  /// Adds another energy to this one
  EnergyKwh add(EnergyKwh other) => EnergyKwh._(_value + other._value);

  /// Subtracts another energy from this one
  EnergyKwh subtract(EnergyKwh other) {
    final newValue = _value - other._value;
    if (newValue < 0) {
      return const EnergyKwh._(0);
    }
    return EnergyKwh._(newValue);
  }

  /// Multiplies this energy by a factor
  EnergyKwh multiply(double factor) {
    if (factor < 0) {
      throw ArgumentError('Factor cannot be negative, got $factor');
    }
    return EnergyKwh._(_value * factor);
  }

  /// Divides this energy by a factor
  EnergyKwh divide(double factor) {
    if (factor <= 0) {
      throw ArgumentError('Factor must be positive, got $factor');
    }
    return EnergyKwh._(_value / factor);
  }

  @override
  List<Object?> get props => [_value];

  @override
  String toString() => '${_value.toStringAsFixed(2)} kWh';

  /// Common energy values
  static const EnergyKwh zero = EnergyKwh._(0);
  static const EnergyKwh oneKwh = EnergyKwh._(1);
  static const EnergyKwh tenKwh = EnergyKwh._(10);
  static const EnergyKwh hundredKwh = EnergyKwh._(100);
}
