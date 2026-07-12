import 'package:json_annotation/json_annotation.dart';

part 'join_group_model.g.dart';

@JsonSerializable(createFactory: false)
class JoinGroupModel {
  const JoinGroupModel({
    required this.inviteCode,
  });

  final String inviteCode;

  Map<String, dynamic> toJson() => _$JoinGroupModelToJson(this);
}
