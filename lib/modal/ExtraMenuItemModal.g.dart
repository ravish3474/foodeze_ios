// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExtraMenuItemModal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExtraMenuItemModalAdapter extends TypeAdapter<ExtraMenuItemModal> {
  @override
  final int typeId = 2;

  @override
  ExtraMenuItemModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExtraMenuItemModal(
      id: fields[0] as String?,
      name: fields[1] as String?,
      price: fields[2] as String?,
      restaurant_menu_extra_section_id: fields[3] as String?,
      title: fields[6] as String?,
      restaurant_id: fields[4] as String?,
      restaurant_menu_item_id: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ExtraMenuItemModal obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.restaurant_menu_extra_section_id)
      ..writeByte(4)
      ..write(obj.restaurant_id)
      ..writeByte(5)
      ..write(obj.restaurant_menu_item_id)
      ..writeByte(6)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExtraMenuItemModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
