// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CardModal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardModalAdapter extends TypeAdapter<CardModal> {
  @override
  final int typeId = 3;

  @override
  CardModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardModal(
      rowId: fields[0] as String?,
      cardNumber: fields[1] as String?,
      expiryDate: fields[2] as String?,
      cardHolderName: fields[3] as String?,
      cvvCode: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CardModal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.rowId)
      ..writeByte(1)
      ..write(obj.cardNumber)
      ..writeByte(2)
      ..write(obj.expiryDate)
      ..writeByte(3)
      ..write(obj.cardHolderName)
      ..writeByte(4)
      ..write(obj.cvvCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
