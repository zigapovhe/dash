import 'package:dash/helpers/converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'chatDto.g.dart';
part 'chatDto.freezed.dart';
@freezed
class Chat with _$Chat {
  const factory Chat({
    required String userId,
    required String message,
    @TimestampConverter()
    required DateTime timestamp,
    required String sender,
  }) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}