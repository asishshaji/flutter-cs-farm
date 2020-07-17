// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Orders.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderAdapter extends TypeAdapter<Order> {
  @override
  Order read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Order(
      orderCount: fields[0] as String,
      product: fields[1] as Product,
    );
  }

  @override
  void write(BinaryWriter writer, Order obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.orderCount)
      ..writeByte(1)
      ..write(obj.product);
  }

  @override
  // TODO: implement typeId
  int get typeId => 2;
}
