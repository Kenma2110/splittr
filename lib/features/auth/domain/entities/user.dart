import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const User({
    this.id,
    this.firebaseUid,
    this.name,
    this.email,
    this.phone,
  });

  @override
  final String? id;
  @override
  final String? firebaseUid;
  @override
  final String? name;
  @override
  final String? email;
  @override
  final String? phone;
}
