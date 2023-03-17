// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orcamento.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrcamentoAdapter extends TypeAdapter<Orcamento> {
  @override
  final int typeId = 2;

  @override
  Orcamento read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Orcamento(
      id: fields[0] as int,
      valorPrevisao: fields[1] as double,
      dataPrevisao: fields[2] as DateTime,
      categoria: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Orcamento obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.valorPrevisao)
      ..writeByte(2)
      ..write(obj.dataPrevisao)
      ..writeByte(3)
      ..write(obj.categoria);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrcamentoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
