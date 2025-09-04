import 'package:equatable/equatable.dart';

/// Represents a user
class User extends Equatable {
  final String id;
  final String? email;
  final String? name;
  final bool isAnonymous;
  final DateTime createdAt;
  final DateTime? lastSignInAt;

  const User({
    required this.id,
    this.email,
    this.name,
    required this.isAnonymous,
    required this.createdAt,
    this.lastSignInAt,
  });

  User copyWith({
    String? id,
    String? email,
    String? name,
    bool? isAnonymous,
    DateTime? createdAt,
    DateTime? lastSignInAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      createdAt: createdAt ?? this.createdAt,
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        isAnonymous,
        createdAt,
        lastSignInAt,
      ];
}
