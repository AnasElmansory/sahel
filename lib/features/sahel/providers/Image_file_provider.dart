import 'dart:io';

import 'package:path_provider/path_provider.dart' as path;
import 'package:path/path.dart' as p;

class FileImageProvider {
  static Future<Directory> getPath() async =>
      await path.getExternalStorageDirectory();

  Future<File> getIMGFile(String _dirPath, int imageIndex) async {
    final _appDir = await getPath();
    final _imageName = "IMG_${imageIndex.toString().padLeft(2, '0')}.jpg";
    final _dirpath = p.join(_appDir.path, _dirPath);
    final _imagePath = p.join(_dirpath, _imageName);
    final _unitDir = Directory(_imagePath)..createSync(recursive: true);
    return File(_unitDir.path);
  }
}
