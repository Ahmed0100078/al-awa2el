import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gr_zoom/gr_zoom_platform_interface.dart';

class MeetingWidget extends StatelessWidget {
  late final ZoomOptions? zoomOptions;
  late final ZoomMeetingOptions? meetingOptions;
  late final Timer? timer;
  final String? meetingId;
  final String? meetingPassword;
  final String? userId;
  final String? meetingTitle;

  MeetingWidget(
      {Key? key,
      this.meetingId,
      this.meetingPassword,
      this.userId,
      this.meetingTitle,
      this.zoomOptions,
      this.meetingOptions,
      this.timer})
      : super(key: key) {
    // this.zoomOptions = ZoomOptions(
    //   domain: "zoom.us",
    //   appKey: "YFjwuVW9JYxCulhS9sd5PZZS3Tong5YrcsUp",
    //   appSecret: "00dDf0nTC7pFdAwpDfUkdy7ycaDQa8VpnxJw",
    // );
    //
    // this.meetingOptions = ZoomMeetingOptions(
    //     userId: '$userId',
    //     meetingId: '$meetingId',
    //     meetingPassword: '$meetingPassword',
    //     disableDialIn: "true",
    //     disableDrive: "true",
    //     disableInvite: "true",
    //     disableShare: "true",
    //     noAudio: "false",
    //     // disableTitlebar: "false",
    //     // viewOptions: "false",
    //     noDisconnectAudio: "false");
  }

  joinMeeting(BuildContext context) {
    bool _isMeetingEnded(String status) {
      var result = false;

      if (Platform.isAndroid)
        result = status == "MEETING_STATUS_DISCONNECTING" ||
            status == "MEETING_STATUS_FAILED";
      else
        result = status == "MEETING_STATUS_IDLE";

      return result;
    }

    if (meetingId!.isNotEmpty && meetingPassword!.isNotEmpty) {
      ZoomOptions zoomOptions = ZoomOptions(
        domain: "zoom.us",
        appKey: "XKE4uWfeLwWEmh78YMbC6mqKcF8oM4YHTr9I", //API KEY FROM ZOOM
        appSecret:
            "bT7N61pQzaLXU6VLj9TVl7eYuLbqAiB0KAdb", //API SECRET FROM ZOOM
      );
      var meetingOptions = ZoomMeetingOptions(
          userId:
              'username', //pass username for join meeting only --- Any name eg:- EVILRATT.
          meetingId: meetingId!, //pass meeting id for join meeting only
          meetingPassword:
              meetingPassword!, //pass meeting password for join meeting only
          disableDialIn: "true",
          disableDrive: "true",
          disableInvite: "true",
          disableShare: "true",
          // disableTitlebar: "false",
          // viewOptions: "true",
          noAudio: "false",
          noDisconnectAudio: "false");

      var zoom = ZoomPlatform.instance;
      zoom.initZoom(zoomOptions).then((results) {
        if (results[0] == 0) {
          zoom.onMeetingStatus().listen((status) {
            print("[Meeting Status Stream] : " + status[0] + " - " + status[1]);
            if (_isMeetingEnded(status[0])) {
              print("[Meeting Status] :- Ended");
              timer!.cancel();
            }
          });
          print("listen on event channel");
          zoom.joinMeeting(meetingOptions).then((joinMeetingResult) {
            timer = Timer.periodic(new Duration(seconds: 2), (timer) {
              zoom.meetingStatus(meetingOptions.meetingId).then((status) {
                print("[Meeting Status Polling] : " +
                    status[0] +
                    " - " +
                    status[1]);
              });
            });
          });
        }
      }).catchError((error) {
        print("[Error Generated] : " + error);
      });
    } else {
      if (meetingId!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Enter a valid meeting id to continue."),
        ));
      } else if (meetingPassword!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Enter a meeting password to start."),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$meetingTitle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Builder(
          builder: (context) {
            // The basic Material Design action button.
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF001068), // foreground
              ),
              onPressed: () => {joinMeeting(context)},
              child: Text('Join'),
            );
          },
        ),
      ),
    );
  }
}
