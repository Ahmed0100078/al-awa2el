import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/core/widgets/image_zoom_widget.dart';
import 'package:madaresco/features/LessonDetails/presentation/manager/lesson_details_view_model.dart';
import 'package:madaresco/features/LessonDetails/presentation/widgets/attatchment_row.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/OpeningScreen/OpeningScreen.dart';
import 'package:madaresco/features/TeacherOpeningScreen/teacher_opening_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/widgets/video_widget.dart';
import '../../../../injection_container.dart';
import '../../../../main.dart';

class NewLessonDetailsPage extends HookWidget {
  const NewLessonDetailsPage({required this.lessonID, Key? key})
      : super(key: key);
  final int lessonID;

  @override
  Widget build(BuildContext context) {
    final time = useState<int?>(null);
    final timeLeft = useState<String>('');
    final progressDialog = useState<ProgressDialog?>(null);
    final _animationController =
        useAnimationController(duration: Duration(milliseconds: 100));
    final progressValue = useState<double>(0);
    final duration = useState(Duration.zero);
    final isPlaying = useState<bool>(false);
    final position = useState(Duration.zero);
    final _isVoiceLoading = useState<bool>(false);
    final audioPlayer = useState<AudioPlayer>(AudioPlayer());
    final isStarted = useState<bool>(false);
    final local = AppLocalizations.of(context);
    final LessonDetailsViewModel vm =
        Provider.of<LessonDetailsViewModel>(context);
    vm.lessonId = lessonID;
    final maxDuration = useState<double>(100);
    useEffect(() {
      vm.toast.addListener(() {
        if (vm.toast.value.getContentIfNotHandled() != null) {
          if (vm.toast.value.peekContent() == SERVER_FAILURE_MESSAGE) {
            Fluttertoast.showToast(msg: SERVER_FAILURE_MESSAGE);
          } else {
            Fluttertoast.showToast(
                msg: local.translate(vm.toast.value.peekContent()));
          }
        }
      });
      _animationController.addStatusListener((status) {
        if (status == AnimationStatus.completed && _isVoiceLoading.value) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed &&
            _isVoiceLoading.value) {
          _animationController.forward();
        }
      });
      /// On Audio Position Change Listener
      audioPlayer.value.onAudioPositionChanged.listen((Duration p) async {
        if (!context.mounted) return;
        position.value = p;

        print('Current position: $p');
        time.value = await audioPlayer.value.getDuration();
        duration.value = p;
        if (duration.value == Duration.zero) {
          timeLeft.value = "0s:0s";
        } else {
          timeLeft.value =
              "${duration.value.inSeconds}s:${time.value! ~/ 1000}s";

          _isVoiceLoading.value = false;
        }
        if (time.value == null || duration.value == Duration.zero) {
          progressValue.value = 0.0;
        } else {
          progressValue.value = (duration.value.inMilliseconds) / time.value!;
        }
        print(progressValue.value);
      });
      /// On PlayerState Change Listener
      audioPlayer.value.onPlayerStateChanged.listen((PlayerState state) {
        print("$state");
        if (state == PlayerState.PLAYING) {
          isPlaying.value = true;
        } else {
          if (context.mounted) {
            isPlaying.value = false;
          }
        }
      });
      /// On PlayerState Change Listener
      audioPlayer.value.onDurationChanged.listen((Duration d) {
        maxDuration.value = d.inMilliseconds / 1000;
      });
      /// Progress Dialog Setter
      progressDialog.value = ProgressDialog(context);
      /// DISPOSE
      return () async {
        await audioPlayer.value.stop();
        await audioPlayer.value.dispose();
      };
    },
        /// RUN ONLY ONCE
        const []);
    /// END OF USE EFFECT
    /// Build Helpers Methods
    /// Seeks AudioPlayer to Specific Duration
    Future<int?> seekTo(Duration duration) async =>
        await audioPlayer.value.seek(duration);

    ///
    ///
    /// On Start Playing Handler
    startPlaying(String path) async {
      if (!isStarted.value) {
        _isVoiceLoading.value = true;
        _animationController.forward();
        await audioPlayer.value.play(path);
        isStarted.value = true;
      } else {
        await audioPlayer.value.play(path,
            position: position.value ==
                    Duration(milliseconds: (maxDuration.value * 1000).toInt())
                ? Duration.zero
                : position.value);
      }
    }
    /// On Play/Pause Press
    void _handleOnPressed() {
      String url = vm.entity.audio!.url;
      isPlaying.value ? audioPlayer.value.pause() : startPlaying(url);
      isPlaying.value = !isPlaying.value;
      (isPlaying.value)
          ? _animationController.forward()
          : _animationController.reverse();
    }

    Widget getViews() => (vm.entity.attachments.isNotEmpty)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Text(
                local.translate('attach_lable'),
                style: TextStyle(color: kAccentColor),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: vm.entity.attachments
                    .map((e) => AttatchmentRow(
                          attach: e,
                          local: local,
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 20.0,
              )
            ],
          )
        : SizedBox.shrink();

    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: vm.loading,
        builder: (context, bool loading, child) {
          return ModalProgressHUD(inAsyncCall: loading, child: child!);
        },
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 120,
                child: Material(
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0)),
                  child: AppBar(
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Color(0xFF001068),
                          Color(0xFF001068),
                        ],
                      )),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          try {
                            mainNavigatorKey.currentState!.pop();
                          } catch (e) {
                            mainNavigatorKey.currentState!.pop();
                          }
                        },
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.0),
                            child: Icon(Icons.arrow_forward_ios)),
                      ),
                    ],
                    leading: GestureDetector(
                      onTap: () {
                        try {
                          scaffoldKey.currentState!.openDrawer();
                        } catch (e) {
                          teacherScaffoldKey.currentState!.openDrawer();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.0),
                        child: Image.asset(
                          'assets/images/menu.png',
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                    centerTitle: true,
                    title: Text(
                      local.translate('home_work'),
                      style: GoogleFonts.cairo(
                          fontSize: 16.0, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 100,
              bottom: 0,
              right: 10,
              left: 10,
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                )),
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                vm.entity.name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                ),
                                softWrap: true,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 26.0),
                              child: Text(
                                vm.entity.date,
                                style: TextStyle(
                                    color: Color(0xFF001068),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          vm.entity.description,
                          style: TextStyle(color: Colors.black, fontSize: 19),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(/// ِAdded Hers New Features
                          '${vm.entity.stage?.name??'لا يوجد حاليا '}${vm.entity.section?.name ?? ''}${vm.entity.subject?.name != null ? ' - ${vm.entity.subject!.name}' : ''}',
                          style: TextStyle(color: Colors.black, fontSize: 19),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (vm.entity.externalLink.isNotEmpty) ...[
                          Text(
                            local.translate('lesson_other_link'),
                            style: TextStyle(color: kAccentColor),
                          ),
                          InkWell(
                            onTap: () async {
                              if (Platform.isAndroid) {
                                await launchUrl(
                                    Uri.parse(vm.entity.externalLink));
                              } else {
                                final bool nativeAppLaunchSucceeded =
                                    await launchUrl(
                                  Uri.parse(vm.entity.externalLink),
                                  mode:
                                      LaunchMode.externalNonBrowserApplication,
                                );
                                if (!nativeAppLaunchSucceeded) {
                                  await launchUrl(
                                    Uri.parse(vm.entity.externalLink),
                                    mode: LaunchMode.inAppWebView,
                                  );
                                }
                              }
                            },
                            child: Text(
                              local.translate('pressToGo'),
                              style: TextStyle(color: kAccentColor),
                            ),
                          ),
                        ],
                        SizedBox(
                          height: 20.0,
                        ),
                        if (vm.entity.images.isNotEmpty) ...[
                          Text(
                            local.translate('images_label'),
                            style: TextStyle(color: kAccentColor),
                          ),
                          ...List.generate(
                              vm.entity.images.length,
                              (index) => Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ImageZoomScreen(
                                                    image: vm.entity
                                                        .images[index].url)),
                                          );
                                        },
                                        child: Text(
                                          local.translate('show') +
                                              ' ' +
                                              local.translate('image') +
                                              ' ' +
                                              local.translate('number') +
                                              (index + 1).toString(),
                                          style: TextStyle(color: kAccentColor),
                                        ),
                                      ),
                                    ],
                                  ))
                        ],
                        SizedBox(
                          height: 20.0,
                        ),
                        /// If There's a Video
                        if (vm.entity.video != null &&
                            vm.entity.video!.url != '') ...[
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ChangeNotifierProvider(
                                    create: (_) => sl<LessonDetailsViewModel>(),
                                    child: VideoScreen(
                                        video: vm.entity.video!.url,
                                        lessonDetailsViewModel: vm),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              local.translate('show') +
                                  ' ' +
                                  local.translate('video_lable'),
                              style: TextStyle(color: kAccentColor),
                            ),
                          )
                        ],
                        SizedBox(
                          height: 20.0,
                        ),
                        /// If There's an audio
                        if (vm.entity.audio != null &&
                            vm.entity.audio!.url != '') ...[
                          Text(
                            local.translate('audio_lable'),
                            style: TextStyle(color: kAccentColor),
                          ),
                          /// Audio Player Slider
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kAccentColor),
                                  child: IconButton(
                                      icon: Icon(
                                        isPlaying.value
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        textDirection: TextDirection.rtl,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                      onPressed: _handleOnPressed),
                                ),
                                Expanded(
                                  child: _isVoiceLoading.value
                                      ? Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: LinearProgressIndicator(
                                            backgroundColor:
                                                Colors.white.withAlpha(20),
                                          ),
                                        )
                                      : SliderTheme(
                                          data: SliderThemeData(
                                            thumbShape: RoundSliderThumbShape(
                                                disabledThumbRadius: 6.0,
                                                enabledThumbRadius: 8.0),
                                            trackHeight: 6.0,
                                            activeTrackColor: kAccentColor,
                                            activeTickMarkColor: Colors.white,
                                            thumbColor: kAccentColor,
                                            inactiveTrackColor:
                                                Colors.grey.withAlpha(36),
                                          ),
                                          child: Slider(
                                            label: timeLeft.value,
                                            min: 0.0,
                                            max: maxDuration.value,
                                            onChanged: (value) {
                                              print(value);
                                              seekTo(Duration(
                                                  milliseconds:
                                                      (value * 1000).toInt()));
                                              progressValue.value = value;
                                            },
                                            value:
                                                duration.value.inMilliseconds /
                                                    1000,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        /*Platform.isAndroid ?*/ getViews() /*: SizedBox()*/
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}