import 'package:json_annotation/json_annotation.dart';

part 'add_friend_payload.g.dart';

@JsonSerializable()
class AddFriendPayload {
  const AddFriendPayload({
    this.friendEmail,
    this.friendPhone,
  });

  final String? friendEmail;
  final String? friendPhone;

  Map<String, dynamic> toJson() => _$AddFriendPayloadToJson(this);
}
