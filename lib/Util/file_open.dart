import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

downloadFileToStorage({String url = "", String fileName = ""}) async {
  late final externalDir;
  try {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      if (Platform.isAndroid) {
        externalDir = await getExternalStorageDirectory();
      } else if (Platform.isIOS) {
        externalDir = await getApplicationDocumentsDirectory();
      }
    }
  } catch (e) {
    log(e.toString());
  }
  await FlutterDownloader.enqueue(
    url: url,
    savedDir: externalDir.path,
    fileName: fileName,
    showNotification: true,
    saveInPublicStorage: true,
    openFileFromNotification: true,
  );
}

enum DownloadStatus { SUCCESS, LOADING, ERROR, INIT }

Future openFile({required String url, String? fileName}) async {
  final name = fileName ?? url.split('/').last;
  final file = await downloadFile(url, name);
  if (file == null) return DownloadStatus.ERROR;
  OpenFilex.open(file.path);
  return DownloadStatus.SUCCESS;
}

Future<File?> downloadFile(String url, String name) async {
  final appStorage = await getApplicationDocumentsDirectory();
  final file = File('${appStorage.path}/$name');
  try {
    final response = await Dio().get(url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ));

    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();
    return file;
  } catch (e) {
    print("$e");
    return null;
  }
}
