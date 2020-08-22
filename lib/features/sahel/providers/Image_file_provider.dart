import 'dart:io';

import 'package:path_provider/path_provider.dart' as path;
import 'package:path/path.dart' as p;

class FileImageProvider {
  FileImageProvider._internal();
  Future<void> getPath() async =>
      _absPath = await path.getExternalStorageDirectory();
  static FileImageProvider _instance = FileImageProvider._internal();
  factory FileImageProvider() => _instance;
  static Directory _absPath;

  File getIMGFile(String unitPath, int imageIndex) {
    if (_absPath != null) {
      final imageFile = "IMG_${imageIndex.toString().padLeft(2, '0')}.jpg";
      final unitDir = Directory(p.join(_absPath.path, unitPath))
        ..createSync(recursive: true);
      return File(p.join(unitDir.path, imageFile));
    }
    throw NullThrownError();
  }
}
