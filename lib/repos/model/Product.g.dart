// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  Product read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      category: fields[0] as String,
      sId: fields[1] as String,
      name: fields[2] as String,
      price: fields[3] as String,
      count: fields[4] as int,
      details: fields[5] as String,
      benifits: fields[6] as String,
      farmId: fields[7] as String,
      imageurl: fields[8] as String,
      crossprice: fields[9] as String,
      offerType: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.sId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.count)
      ..writeByte(5)
      ..write(obj.details)
      ..writeByte(6)
      ..write(obj.benifits)
      ..writeByte(7)
      ..write(obj.farmId)
      ..writeByte(8)
      ..write(obj.imageurl)
      ..writeByte(9)
      ..write(obj.crossprice)
      ..writeByte(10)
      ..write(obj.offerType);
  }

  @override
  // TODO: implement typeId
  int get typeId => 1;
}
