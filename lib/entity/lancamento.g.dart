// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lancamento.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LancamentoAdapter extends TypeAdapter<Lancamento> {
  @override
  final int typeId = 1;

  @override
  Lancamento read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lancamento(
      id: fields[2] as int?,
      emissao: fields[3] as DateTime,
      valor: fields[4] as double,
      observacao: fields[5] as String,
      categoria: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Lancamento obj) {
    writer
      ..writeByte(5)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.emissao)
      ..writeByte(4)
      ..write(obj.valor)
      ..writeByte(5)
      ..write(obj.observacao)
      ..writeByte(6)
      ..write(obj.categoria);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LancamentoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
