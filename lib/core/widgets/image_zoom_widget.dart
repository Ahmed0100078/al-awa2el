import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_view/photo_view.dart';
import '../../Util/file_open.dart';
import '../language/app_loclaizations.dart';

class ImageZoomScreen extends StatelessWidget {
  final String image;

  const ImageZoomScreen({required this.image});
  final DownloadStatus downloadStatusInit = DownloadStatus.INIT;
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF001068),
          elevation: 0,
          leading: InkWell(
            child: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
          actions: [
            StatefulBuilder(
                builder: (BuildContext context, StateSetter stateSetter) {
              DownloadStatus downloadStatus = downloadStatusInit;
              return Visibility(
                visible: downloadStatus != DownloadStatus.LOADING,
                child: IconButton(
                  icon: Icon(Icons.download),
                  color: Colors.white,
                  onPressed: () {
                    if (Platform.isAndroid) {
                      downloadFileToStorage(url: image, fileName: "image");
                    } else {
                      stateSetter(
                          () => downloadStatus = DownloadStatus.LOADING);
                      openFile(
                        url: image,
                      ).then((value) {
                        stateSetter(() => downloadStatus = value);
                        if (value == DownloadStatus.ERROR) {
                          Fluttertoast.showToast(
                            msg: local.translate("download_error"),
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                          );
                        }
                      });
                    }
                  },
                ),
                replacement: Center(
                    child:
                        const CircularProgressIndicator(color: Colors.white)),
              );
            }),
          ],
        ),
        body: Container(
          alignment: AlignmentDirectional.center,
          child: PhotoView(
            imageProvider: NetworkImage(image),
            backgroundDecoration: BoxDecoration(color: Colors.white),
            errorBuilder: (context, url, error) => const Icon(
              Icons.error,
              color: Colors.red,
            ),
            enableRotation: true,
            enablePanAlways: true,
            wantKeepAlive: true,
            loadingBuilder: (context, url) => CupertinoActivityIndicator(
              animating: true,
              radius: 30,
              color: Color(0xFF001068),
            ),
          ),
        ),
      ),
    );
  }
}
