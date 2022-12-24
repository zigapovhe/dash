
import 'package:json_annotation/json_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime, int> {
  const TimestampConverter();

  @override
  DateTime fromJson(int json) => DateTime.fromMillisecondsSinceEpoch(json);

  @override
  int toJson(DateTime object) => object.millisecondsSinceEpoch;
}

/*
class RoleTypeConverter implements JsonConverter<RoleType, int> {
  const RoleTypeConverter();

  @override
  RoleType fromJson(int json) => RoleType.values[json];

  @override
  int toJson(RoleType object) => object.index;
}

 */