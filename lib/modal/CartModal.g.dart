// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CartModal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartModalAdapter extends TypeAdapter<CartModal> {
  @override
  final int typeId = 1;

  @override
  CartModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartModal(
      id: fields[0] as String?,
      name: fields[1] as String?,
      description: fields[2] as String?,
      category: fields[3] as String?,
      price: fields[4] as String?,
      quantity: fields[5] as String?,
      image: fields[6] as String?,
      restaurantMenuId: fields[7] as String?,
      restaurantId: fields[8] as String?,
      restaurantName: fields[9] as String?,
      rowId: fields[10] as String?,
      extraItemList: (fields[11] as List?)?.cast<ExtraMenuItemModal>(),
      lat: fields[12] as String?,
      long: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CartModal obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.quantity)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.restaurantMenuId)
      ..writeByte(8)
      ..write(obj.restaurantId)
      ..writeByte(9)
      ..write(obj.restaurantName)
      ..writeByte(10)
      ..write(obj.rowId)
      ..writeByte(11)
      ..write(obj.extraItemList)
     ..writeByte(12)
      ..write(obj.lat)
     ..writeByte(13)
      ..write(obj.long)

    ;
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
