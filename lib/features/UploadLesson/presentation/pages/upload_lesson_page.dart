import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/OpeningScreen/OpeningScreen.dart';
import 'package:madaresco/features/Register/domain/entities/item_entity.dart';
import 'package:madaresco/features/TeacherOpeningScreen/teacher_opening_screen.dart';
import 'package:madaresco/features/UploadLesson/presentation/manager/upload_lesson_view_model.dart';
import 'package:madaresco/features/UploadLesson/presentation/widgets/upload_completed_dialog.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import '../../../../main.dart';

class UploadLessonPage extends StatefulWidget {
  @override
  _UploadLessonPageState createState() => _UploadLessonPageState();
}

class _UploadLessonPageState extends State<UploadLessonPage>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    UploadLessonViewModel vm = Provider.of<UploadLessonViewModel>(context);
    vm.getAudioFilePath();
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

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
                  height: 140,
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
                        local.translate('add_lesson'),
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
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              local.translate('choose_grade'),
                              style: TextStyle(
                                color: kAccentColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: Colors.grey),
                              ),
                              height: 40,
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: DropdownButton<Item>(
                                value: vm.selectedStage.id == null
                                    ? null
                                    : vm.selectedStage,
                                hint: Text(
                                  local.translate('choose_grade'),
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                underline: Container(),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                ),
                                iconSize: 30,
                                style: TextStyle(color: Colors.black),
                                isExpanded: true,
                                onChanged: (Item? newValue) {
                                  vm.selectedStage = newValue!;
                                },
                                items: vm.stageEntity.items!
                                    .map<DropdownMenuItem<Item>>((Item value) {
                                  return DropdownMenuItem<Item>(
                                    value: value,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(value.name!),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              local.translate('choose_class'),
                              style: TextStyle(
                                color: kAccentColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: Colors.grey),
                              ),
                              height: 40,
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: DropdownButton<Item>(
                                value: vm.selectedGrades.id == null
                                    ? null
                                    : vm.selectedGrades,
                                underline: Container(),
                                hint: Text(
                                  local.translate('choose_class'),
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                ),
                                iconSize: 30,
                                style: TextStyle(color: Colors.black),
                                isExpanded: true,
                                onChanged: (Item? newValue) {
                                  vm.selectedGrades = newValue!;
                                },
                                items: vm.grades.items!
                                    .map<DropdownMenuItem<Item>>((Item value) {
                                  return DropdownMenuItem<Item>(
                                    value: value,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                        value.name!,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Text(
                                        local.translate('choose_subject'),
                                        style: TextStyle(
                                          color: kAccentColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        height: 40,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: DropdownButton<Item>(
                                          value: vm.selectedSubject.id == null
                                              ? null
                                              : vm.selectedSubject,
                                          underline: Container(),
                                          hint: Text(
                                            local.translate('choose_subject'),
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black,
                                          ),
                                          iconSize: 30,
                                          style: TextStyle(color: Colors.black),
                                          isExpanded: true,
                                          onChanged: (Item? newValue) {
                                            vm.selectedSubject = newValue!;
                                          },
                                          items: vm.subjects.items!
                                              .map<DropdownMenuItem<Item>>(
                                                  (Item value) {
                                            return DropdownMenuItem<Item>(
                                              value: value,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                child: Text(
                                                  value.name!,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 16.0,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text(
                                      local.translate('choose_sub_grade'),
                                      style: TextStyle(
                                        color: kAccentColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      height: 40,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      child: DropdownButton<Item>(
                                        value: vm.selectedSection.id == null
                                            ? null
                                            : vm.selectedSection,
                                        hint: Text(
                                          local.translate('choose_sub_grade'),
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        underline: Container(),
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                        iconSize: 30,
                                        style: TextStyle(color: Colors.black),
                                        isExpanded: true,
                                        onChanged: (Item? newValue) {
                                          vm.selectedSection = newValue!;
                                        },
                                        items: vm.sections.items!
                                            .map<DropdownMenuItem<Item>>(
                                                (Item value) {
                                          return DropdownMenuItem<Item>(
                                            value: value,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Text(
                                                value.name!,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              local.translate('lesson_title'),
                              style: TextStyle(
                                color: kAccentColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return local.translate('title_error');
                                }
                                return null;
                              },
                              onChanged: (value) {
                                vm.lessonTitle = value;
                              },
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              local.translate('lesson_details'),
                              style: TextStyle(
                                color: kAccentColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return local.translate('details_error');
                                }
                                return null;
                              },
                              onChanged: (value) {
                                vm.lessonDetails = value;
                              },
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                              minLines: 4,
                              maxLines: 9,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              local.translate('lesson_other_link'),
                              style: TextStyle(
                                color: kAccentColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            TextFormField(
                              onChanged: (value) {
                                vm.lessonExternalLink = value;
                              },
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                              minLines: 2,
                              maxLines: 2,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                vm.pickUpImages();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Colors.grey),
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Text(
                                                local.translate('upload_photo'),
                                                style: TextStyle(
                                                  color: kAccentColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                local.translate(
                                                    'upload_photo_desc'),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.grey.shade300),
                                          padding: EdgeInsets.all(10.0),
                                          child: Image.asset(
                                            'assets/images/addi.png',
                                            height: 40.0,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ],
                                    ),
                                    vm.images.isEmpty
                                        ? SizedBox()
                                        : Row(
                                            children: vm.images
                                                .map((e) => Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        child: SizedBox(
                                                          width: 40,
                                                          height: 35,
                                                          child: AssetThumb(
                                                            asset: e,
                                                            width: 40,
                                                            height: 35,
                                                          ),
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                          )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                vm.pickUpVideo();
                              },
                              behavior: HitTestBehavior.translucent,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Colors.grey),
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Text(
                                            local.translate('upload_video'),
                                            style: TextStyle(
                                              color: kAccentColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            local
                                                .translate('upload_video_desc'),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          vm.selectedVideo != null
                                              ? Column(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Text(
                                                      local.translate(
                                                              'selected_video') +
                                                          ' : \n ${vm.selectedVideo!.path.split('/').last}',
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.grey.shade300),
                                      padding: EdgeInsets.all(10.0),
                                      child: Image.asset(
                                        'assets/images/add1.png',
                                        height: 40.0,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            RecordRow(),
                            SizedBox(
                              height: 16.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                vm.pickUpAttachments();
                              },
                              behavior: HitTestBehavior.translucent,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Colors.grey),
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Text(
                                                local.translate('upload_files'),
                                                style: TextStyle(
                                                  color: kAccentColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                local.translate(
                                                    'upload_files_desc'),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.grey.shade300),
                                          padding: EdgeInsets.all(10.0),
                                          child: Image.asset(
                                            'assets/images/add.png',
                                            color: Colors.black,
                                            height: 40.0,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ],
                                    ),
                                    vm.attachments.isEmpty
                                        ? SizedBox()
                                        : Column(
                                            children: vm.attachments
                                                .map((e) => Card(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Center(
                                                            child: Text(e.path
                                                                .split('/')
                                                                .last)),
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16.0)),
                                                    ))
                                                .toList(),
                                          )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  vm.addLesson().then((value) {
                                    if (value!) {
                                      showThankYouDialog(context);
                                      //Navigator.pop(context);
                                    }
                                  });
                                }
                              },
                              style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(80.0))),
                                padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                    const EdgeInsets.all(0.0)),
                                textStyle:
                                    MaterialStateProperty.all<TextStyle?>(
                                        TextStyle(color: Colors.white)),
                              ),
                              child: Container(
                                width: double.infinity,
                                decoration: kBoxDecoration.copyWith(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(87.0))),
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Center(
                                    child: Text(local.translate('add_lesson'),
                                        style: TextStyle(fontSize: 20))),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_RecordRowState? lastAudioPlayerPlayed;

class RecordRow extends StatefulWidget {
  @override
  _RecordRowState createState() => _RecordRowState();
}

class _RecordRowState extends State<RecordRow>
    with SingleTickerProviderStateMixin {
  bool isRecording = false;
  AnimationController? _animationController;
  bool isPlaying = false;
  double progressValue = 0;
  bool isStarted = false;
  Duration duration = new Duration();
  Duration position = new Duration();
  bool _isVoiceLoading = false;
  int? time;
  String timeLeft = "";
  AudioPlayer audioPlayer = AudioPlayer();
  ProgressDialog? progressDialog;

  startPlaying(File path) async {
    if (lastAudioPlayerPlayed != null) {
      lastAudioPlayerPlayed!.audioPlayer.pause();
      lastAudioPlayerPlayed!.setState(() {});
    }
    if (!isStarted) {
      setState(() {
        _isVoiceLoading = true;
        _animationController!.forward();
      });
      audioPlayer.play(path.path, isLocal: true);

      // if (result == 1) {
      // } else {
      //   print(result);
      // }
      isStarted = true;
    } else
      await audioPlayer.play(path.path);
    // time = await audioPlayer.getDuration();
    lastAudioPlayerPlayed = this;
  }

  seekTo(Duration duration) {
    audioPlayer..seek(duration);
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed && _isVoiceLoading) {
        _animationController!.reverse();
      } else if (status == AnimationStatus.dismissed && _isVoiceLoading) {
        _animationController!.forward();
      }
    });

    audioPlayer.onAudioPositionChanged.listen((Duration p) async {
      print('Current position: $p');
      time = await audioPlayer.getDuration();
      duration = p;
      if (duration == Duration.zero) {
        timeLeft = "0s:0s";
      } else {
        timeLeft = "${duration.inSeconds}s:${time! ~/ 1000}s";
        setState(() {
          _isVoiceLoading = false;
        });
      }
      if (time == null) {
        progressValue = 0.0;
      } else {
        progressValue = (duration.inMilliseconds) / time!;
      }
      print(progressValue);
      setState(() {});
    });

    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      print("$state");
      if (state == PlayerState.PLAYING) {
        setState(() {
          isPlaying = true;
        });
      } else {
        if (mounted) {
          setState(() {
            isPlaying = false;
          });
        }
        if (state == PlayerState.STOPPED) {
          print('stopped');
        }
      }
    });

    progressDialog = ProgressDialog(context);
  }

  void dispose() async {
    super.dispose();
    _animationController!.dispose();
    await audioPlayer.stop();
    lastAudioPlayerPlayed = null;
  }

  Color getRecordingColor(UploadLessonViewModel vm) {
    switch (vm.recordingStatus) {
      case RecordState.record:
        return Colors.red.shade700;

      case RecordState.stop:
        return Colors.green.shade700;
      default:
        return Colors.green.shade700;
    }
  }

  EdgeInsets getRecordingPadding(UploadLessonViewModel vm) {
    switch (vm.recordingStatus) {
      case RecordState.record:
        return EdgeInsets.all(20.0);

      case RecordState.stop:
        return EdgeInsets.all(16.0);
      default:
        return EdgeInsets.all(16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Consumer<UploadLessonViewModel>(builder: (context, vm, child) {
      return AnimatedSwitcher(
        duration: Duration(milliseconds: 250),
        child: vm.recordingStatus == RecordState.stop
            ? Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(16.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          print('asddsdsa');
                          vm.clearRecord();
                          audioPlayer.stop();
                          setState(() {
                            progressValue = 0.0;
                            isPlaying = false;
                          });
                        }),
                    Expanded(
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: _isVoiceLoading
                            ? Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.white.withAlpha(20),
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
                                  inactiveTrackColor: Colors.grey.withAlpha(36),
                                ),
                                child: ValueListenableBuilder(
                                  valueListenable: vm.recordingSliderLength!,
                                  builder: (context, length, child) => Slider(
                                    min: 0.0,
                                    max: double.parse(length.toString()),
                                    onChanged: (value) {
                                      print(value);
                                      setState(() {
                                        seekTo(
                                            Duration(seconds: value.toInt()));
                                        progressValue = value;
                                      });
                                    },
                                    value: duration.inSeconds.toDouble(),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: kAccentColor),
                      child: IconButton(
                          icon: AnimatedIcon(
                            textDirection: TextDirection.rtl,
                            size: 30,
                            icon: AnimatedIcons.play_pause,
                            progress: _animationController!,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _handleOnPressed(vm.recordedFile!);
                            setState(() {
                              isPlaying
                                  ? _animationController!.forward()
                                  : _animationController!.reverse();
                            });
                          }),
                    ),
                  ],
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey),
                ),
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (isRecording == false) {
                          print('startRecording');
                          vm.startRecording();
                          setState(() {
                            isRecording = true;
                            progressValue = 0.0;
                          });
                        } else {
                          print('stopRecording');
                          vm.stopRecording();
                          setState(() {
                            isRecording = false;
                          });
                        }
                      },
                      // onTapUp: (details) {
                      //   vm.stopRecording();
                      // },
                      behavior: HitTestBehavior.translucent,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: getRecordingColor(vm)),
                        padding: getRecordingPadding(vm),
                        child: Image.asset(
                          'assets/images/microphone.png',
                          height: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: vm.recordingTime!,
                        builder: (context, time, child) {
                          return Text(
                            vm.recordingStatus == RecordState.record
                                ? time.toString()
                                : local.translate('record'),
                            style: TextStyle(
                              color: vm.recordingStatus == RecordState.record
                                  ? Colors.red
                                  : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }

  void _handleOnPressed(File url) {
    setState(() {
      isPlaying ? audioPlayer.pause() : startPlaying(url);
      isPlaying = !isPlaying;
    });
  }
}
