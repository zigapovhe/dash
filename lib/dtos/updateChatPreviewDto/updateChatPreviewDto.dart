import 'package:dash/enums/ReadStatusEnum.dart';
import 'package:dash/helpers/converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'updateChatPreviewDto.freezed.dart';
part 'updateChatPreviewDto.g.dart';

@freezed
class UpdateChatPreview with _$UpdateChatPreview {
  const factory UpdateChatPreview({
    required String chatId,
    String? title,
    String? lastMessage,
    @TimestampConverter()
    DateTime? timestamp,
    @ReadStatusConverter()
    ReadStatus? readStatus,
    List<String>? userIds,
  }) = _UpdateChatPreview;

  factory UpdateChatPreview.fromJson(Map<String, dynamic> json) => _$UpdateChatPreviewFromJson(json);
}