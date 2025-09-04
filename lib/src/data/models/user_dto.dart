import 'package:isar/isar.dart';
import '../../domain/entities/user.dart';

part 'user_dto.g.dart';

/// Data Transfer Object for User
@collection
class UserDto {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String userId;

  late String? email;
  late String? name;
  late bool isAnonymous;
  late DateTime createdAt;
  late DateTime? lastSignInAt;
  late bool isCurrentUser;

  UserDto();

  UserDto.fromEntity(User user) {
    userId = user.id;
    email = user.email;
    name = user.name;
    isAnonymous = user.isAnonymous;
    createdAt = user.createdAt;
    lastSignInAt = user.lastSignInAt;
    isCurrentUser = false; // Will be set explicitly
  }

  User toEntity() {
    return User(
      id: userId,
      email: email,
      name: name,
      isAnonymous: isAnonymous,
      createdAt: createdAt,
      lastSignInAt: lastSignInAt,
    );
  }

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto()
      ..userId = json['id'] as String
      ..email = json['email'] as String?
      ..name = json['name'] as String?
      ..isAnonymous = json['isAnonymous'] as bool
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..lastSignInAt = json['lastSignInAt'] != null
          ? DateTime.parse(json['lastSignInAt'] as String)
          : null
      ..isCurrentUser = json['isCurrentUser'] as bool;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'email': email,
      'name': name,
      'isAnonymous': isAnonymous,
      'createdAt': createdAt.toIso8601String(),
      'lastSignInAt': lastSignInAt?.toIso8601String(),
      'isCurrentUser': isCurrentUser,
    };
  }
}
