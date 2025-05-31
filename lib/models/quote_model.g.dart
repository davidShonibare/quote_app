// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuoteModelAdapter extends TypeAdapter<QuoteModel> {
  @override
  final int typeId = 0;

  @override
  QuoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuoteModel(
      quote: fields[0] as String,
      writer: fields[1] as String,
      index: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, QuoteModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.quote)
      ..writeByte(1)
      ..write(obj.writer)
      ..writeByte(2)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuoteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
