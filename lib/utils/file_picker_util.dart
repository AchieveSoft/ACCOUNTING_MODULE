import 'dart:io' show File;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FilePickerUtil {
  static Future<List<dynamic>?> pickMultipleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );

    if (kIsWeb) {
      return result?.files;
    } else {
      return result?.files
          .where((file) => file.path != null)
          .map((file) => File(file as String))
          .toList();
    }
  }
}
