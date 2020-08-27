import 'package:hive/hive.dart';
import 'package:sahel/features/sahel/data/models/user_model.dart';
import 'package:sahel/features/sahel/domain/entities/local_user.dart';

class UserAdapter extends TypeAdapter<LocalUser> {
  @override
  LocalUser read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    String name;
    String uid;
    String email;
    String phoneNumber;
    String photoUrl;
    List<dynamic> favs;
    DateTime lastTimeSignIn;
    for (var i = 0; i < numOfFields; i++) {
      switch (reader.readByte()) {
        case 0:
          uid = reader.readString();
          break;
        case 1:
          name = reader.readString();
          break;
        case 3:
          email = reader.readString();
          break;
        case 4:
          phoneNumber = reader.readString();
          break;
        case 5:
          favs = reader.readList();
          break;
        case 6:
          lastTimeSignIn = reader.read();
          break;
      }
    }
    return LocalUser(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      photoUrl: photoUrl,
      favs: favs,
      lastTimeSignIn: lastTimeSignIn,
      uid: uid,
    );
  }

  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, LocalUser obj) {
    writer.write(7);
    writer.write(0);
    writer.write(obj.uid);
    writer.write(1);
    writer.write(obj.name);
    writer.write(2);
    writer.write(obj.email);
    writer.write(3);
    writer.write(obj.phoneNumber);
    writer.write(4);
    writer.write(obj.photoUrl);
    writer.write(5);
    writer.write(obj.favs);
    writer.write(6);
    writer.write(obj.lastTimeSignIn);
  }
}
