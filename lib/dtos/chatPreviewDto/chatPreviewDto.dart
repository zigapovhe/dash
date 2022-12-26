import 'package:dash/enums/ReadStatusEnum.dart';
import 'package:dash/helpers/converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'chatPreviewDto.freezed.dart';
part 'chatPreviewDto.g.dart';

@freezed
class ChatPreview with _$ChatPreview {
  const factory ChatPreview({
    required String title,
    required String lastMessage,
    @TimestampConverter()
    required DateTime? timestamp,
    @ReadStatusConverter()
    required ReadStatus readStatus,
  }) = _ChatPreview;

  factory ChatPreview.fromJson(Map<String, dynamic> json) => _$ChatPreviewFromJson(json);
}