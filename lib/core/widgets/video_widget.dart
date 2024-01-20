import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';
import '../../Util/file_open.dart';
import '../../features/LessonDetails/presentation/manager/lesson_details_view_model.dart';
import '../language/app_loclaizations.dart';

class VideoScreen extends StatefulWidget {
  final String video;
  final LessonDetailsViewModel lessonDetailsViewModel;

  const VideoScreen(
      {required this.video, required this.lessonDetailsViewModel});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController? controller;
  ChewieController? chewieController;

  videoInit() {
    controller = VideoPlayerController.network(widget.video)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    chewieController = ChewieController(
      videoPlayerController: controller!,
      aspectRatio: controller!.value.aspectRatio,
    );
  }

  DownloadStatus downloadStatus = DownloadStatus.INIT;

  @override
  void initState() {
    super.initState();
    videoInit();
  }

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
              builder: (BuildContext context, StateSetter stateSetter) =>
                  Visibility(
                visible: downloadStatus != DownloadStatus.LOADING,
                child: IconButton(
                  icon: Icon(Icons.download),
                  color: Colors.white,
                  onPressed: () {
                    if (Platform.isAndroid) {
                      downloadFileToStorage(
                          url: widget.video, fileName: "video");
                    } else {
                      stateSetter(
                          () => downloadStatus = DownloadStatus.LOADING);
                      openFile(url: widget.video).then((value) {
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
              ),
            ),
          ],
        ),
        body: Visibility(
          visible: controller!.value.isInitialized,
          child: Chewie(controller: chewieController!),
          replacement: Center(
              child: CupertinoActivityIndicator(
            animating: true,
            radius: 30,
            color: Color(0xFF001068),
          )),
        ),
      ),
    );
  }
}
