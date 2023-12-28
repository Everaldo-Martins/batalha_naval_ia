import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Players extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  late int score;

  Players(this.name, this.score,);
}

class PlayersAdapter extends TypeAdapter<Players> {
  @override
  final int typeId = 0; // Deve ser único para cada TypeAdapter

  @override
  Players read(BinaryReader reader) {
    final fieldsCount = reader.readByte();
    Map<int, dynamic> fields = {};
    for (int i = 0; i < fieldsCount; i++) {
      final key = reader.readByte();
      final dynamic value = reader.read();
      fields[key] = value;
    }

    return Players(
      fields[0] as String,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Players obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.score);
  }
}
