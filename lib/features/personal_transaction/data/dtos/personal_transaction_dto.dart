import 'package:json_annotation/json_annotation.dart';

part 'personal_transaction_dto.g.dart';

@JsonSerializable()
class PersonalTransactionDto {
  const PersonalTransactionDto({
    this.transactionId,
    this.userId,
    this.title,
    this.amount,
    this.note,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  factory PersonalTransactionDto.fromJson(Map<String, dynamic> json) =>
      _$PersonalTransactionDtoFromJson(json);
  final String? transactionId;
  final String? userId;
  final String? title;
  final double? amount;
  final String? note;
  final String? category;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => _$PersonalTransactionDtoToJson(this);
}
