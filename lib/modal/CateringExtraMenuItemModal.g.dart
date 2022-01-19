// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CateringExtraMenuItemModal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CateringExtraMenuItemModalAdapter
    extends TypeAdapter<CateringExtraMenuItemModal> {
  @override
  final int typeId = 5;

  @override
  CateringExtraMenuItemModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };



    return CateringExtraMenuItemModal(
      id :fields[0] as String?,
      menuExtraItemName :fields[1] as String?,
      menuExtraItemPrice : fields[2] as String?,
      menuExtraItemQuantity : fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CateringExtraMenuItemModal obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.menuExtraItemName)
      ..writeByte(2)
      ..write(obj.menuExtraItemPrice)
      ..writeByte(3)
      ..write(obj.menuExtraItemQuantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CateringExtraMenuItemModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
