// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuoteHistoryModelAdapter extends TypeAdapter<QuoteHistoryModel> {
  @override
  final int typeId = 1;

  @override
  QuoteHistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuoteHistoryModel(
      history: (fields[0] as List).cast<QuoteModel>(),
      lastShownTime: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, QuoteHistoryModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.history)
      ..writeByte(1)
      ..write(obj.lastShownTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuoteHistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
