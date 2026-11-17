import 'package:hive/hive.dart';

class Library extends HiveObject {
  final int id;
  final String name;
  final String? image;
  final String genre;
  final String platform;

  Library({
    required this.id,
    required this.name,
    required this.image,
    required this.genre,
    required this.platform,
  });
}

class LibraryAdapter extends TypeAdapter<Library> {
  @override
  final int typeId = 0;

  @override
  Library read(BinaryReader reader) {
    return Library(
      id: reader.readInt(),
      name: reader.readString(),
      image: reader.read() as String?,
      genre: reader.readString(),
      platform: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Library obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.write(obj.image);
    writer.writeString(obj.genre);
    writer.writeString(obj.platform);
  }
}