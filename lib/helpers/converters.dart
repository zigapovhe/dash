
import 'package:dash/enums/ReadStatusEnum.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime, int> {
  const TimestampConverter();

  @override
  DateTime fromJson(int json) => DateTime.fromMillisecondsSinceEpoch(json);

  @override
  int toJson(DateTime object) => object.millisecondsSinceEpoch;
}


class ReadStatusConverter implements JsonConverter<ReadStatus, int> {
  const ReadStatusConverter();

  @override
  ReadStatus fromJson(int json) => ReadStatus.values[json];

  @override
  int toJson(ReadStatus object) => object.index;
}