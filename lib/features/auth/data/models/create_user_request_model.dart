import 'package:json_annotation/json_annotation.dart';

part 'create_user_request_model.g.dart';

@JsonSerializable(createFactory: false)
class CreateUserRequestModel {
  const CreateUserRequestModel({
    required this.name,
    required this.email,
  });

  final String name;
  final String email;

  Map<String, dynamic> toJson() => _$CreateUserRequestModelToJson(this);
}
