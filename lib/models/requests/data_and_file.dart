import 'dart:convert' show jsonEncode;
import 'dart:io' show File;
import 'package:dio/dio.dart' show MultipartFile;
import 'package:flutter/foundation.dart' show kIsWeb;

class DataAndFileRequest {
  final List<dynamic>? files;
  final Map<String, dynamic> data;

  DataAndFileRequest({this.files, required this.data});

  List<dynamic> mapFiles() =>
      kIsWeb
          ? [
            for (dynamic file in files!)
              MultipartFile.fromBytes(file.bytes, filename: file.name),
          ]
          : [
            for (File file in files!)
              MultipartFile.fromFile(
                file.path,
                filename: file.path.split('/').last,
              ),
          ];

  Map<String, dynamic> toJson() => {
    'files': files != null ? mapFiles() : null,
    'data': jsonEncode(data),
  };
}
