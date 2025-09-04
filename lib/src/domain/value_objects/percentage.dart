import 'package:equatable/equatable.dart';

/// Represents a percentage value with validation
class Percentage extends Equatable {
  final double _value;

  const Percentage._(this._value);

  /// Creates a percentage from a value between 0 and 100
  factory Percentage.fromPercent(double percent) {
    if (percent < 0 || percent > 100) {
      throw ArgumentError('Percentage must be between 0 and 100, got $percent');
    }
    return Percentage._(percent);
  }

  /// Creates a percentage from a decimal value between 0 and 1
  factory Percentage.fromDecimal(double decimal) {
    if (decimal < 0 || decimal > 1) {
      throw ArgumentError('Decimal must be between 0 and 1, got $decimal');
    }
    return Percentage._(decimal * 100);
  }

  /// Creates a percentage from a SoC value (0-100)
  factory Percentage.fromSoC(double soc) {
    return Percentage.fromPercent(soc);
  }

  /// Gets the percentage value (0-100)
  double get percent => _value;

  /// Gets the decimal value (0-1)
  double get decimal => _value / 100;

  /// Gets the SoC value (0-100)
  double get soc => _value;

  /// Checks if this percentage is greater than another
  bool isGreaterThan(Percentage other) => _value > other._value;

  /// Checks if this percentage is less than another
  bool isLessThan(Percentage other) => _value < other._value;

  /// Checks if this percentage is greater than or equal to another
  bool isGreaterThanOrEqual(Percentage other) => _value >= other._value;

  /// Checks if this percentage is less than or equal to another
  bool isLessThanOrEqual(Percentage other) => _value <= other._value;

  /// Adds another percentage to this one
  Percentage add(Percentage other) {
    final newValue = _value + other._value;
    if (newValue > 100) {
      return const Percentage._(100);
    }
    return Percentage._(newValue);
  }

  /// Subtracts another percentage from this one
  Percentage subtract(Percentage other) {
    final newValue = _value - other._value;
    if (newValue < 0) {
      return const Percentage._(0);
    }
    return Percentage._(newValue);
  }

  /// Multiplies this percentage by a factor
  Percentage multiply(double factor) {
    final newValue = _value * factor;
    if (newValue > 100) {
      return const Percentage._(100);
    }
    if (newValue < 0) {
      return const Percentage._(0);
    }
    return Percentage._(newValue);
  }

  @override
  List<Object?> get props => [_value];

  @override
  String toString() => '${_value.toStringAsFixed(1)}%';

  /// Common percentage values
  static const Percentage zero = Percentage._(0);
  static const Percentage quarter = Percentage._(25);
  static const Percentage half = Percentage._(50);
  static const Percentage threeQuarters = Percentage._(75);
  static const Percentage full = Percentage._(100);
}
