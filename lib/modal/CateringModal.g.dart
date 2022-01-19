// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CateringModal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CateringModalAdapter extends TypeAdapter<CateringModal> {
  @override
  final int typeId = 4;

  @override
  CateringModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };



    return CateringModal(
     id: fields[0] as String?,
      name:fields[1] as String?,
      price: fields[2] as String?,
      quantity: fields[3] as String?,
      extraItemList:(fields[4] as List?)?.cast<CateringExtraMenuItemModal>(),
    );
  }

  @override
  void write(BinaryWriter writer, CateringModal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.extraItemList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CateringModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
