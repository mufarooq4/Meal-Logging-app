// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_alarm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DateAlarmAdapter extends TypeAdapter<DateAlarm> {
  @override
  final int typeId = 3;

  @override
  DateAlarm read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DateAlarm(
      date: fields[0] as DateTime,
      hour: fields[1] as int,
      minute: fields[2] as int,
      message: fields[3] as String? ?? 'Mess Out Time! Don\'t forget to log your meal.',
    );
  }

  @override
  void write(BinaryWriter writer, DateAlarm obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.hour)
      ..writeByte(2)
      ..write(obj.minute)
      ..writeByte(3)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateAlarmAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
