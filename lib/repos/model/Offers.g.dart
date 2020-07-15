// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Offers.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfferAdapter extends TypeAdapter<Offer> {
  @override
  Offer read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Offer(
      sId: fields[0] as String,
      title: fields[1] as String,
      details: fields[2] as String,
      imageurl: fields[3] as String,
      iV: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Offer obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.sId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.details)
      ..writeByte(3)
      ..write(obj.imageurl)
      ..writeByte(4)
      ..write(obj.iV);
  }

  @override
  // TODO: implement typeId
  int get typeId => 0;
}
