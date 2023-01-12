import 'package:freezed_annotation/freezed_annotation.dart';
part 'memberDto.freezed.dart';
part 'memberDto.g.dart';

@freezed
class Member with _$Member {
  const factory Member({
    required String uid,
    required String email,
    required String? name,
    required String tag,
  }) = _Member;

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
}