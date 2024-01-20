import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Color, Colors;
import 'package:logging/logging.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/Register/domain/entities/item_entity.dart';
import 'package:madaresco/features/Register/domain/use_cases/get_grades_use_case.dart';
import 'package:madaresco/features/Register/domain/use_cases/get_sections_use_case.dart';
import 'package:madaresco/features/UploadLesson/domain/entities/upload_lesson_entity.dart';
import 'package:madaresco/features/UploadLesson/domain/use_cases/get_stages_use_case.dart';
import 'package:madaresco/features/UploadLesson/domain/use_cases/get_subjects_use_case.dart';
import 'package:madaresco/features/UploadLesson/domain/use_cases/upload_lesson_use_case.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class UploadLessonViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;
  ItemsEntity _stageEntity = ItemsEntity(items: []);

  ItemsEntity get stageEntity => _stageEntity;
  ItemsEntity _grades = ItemsEntity(items: []);

  ItemsEntity get grades => _grades;
  ItemsEntity _subjects = ItemsEntity(items: []);

  ItemsEntity get subjects => _subjects;
  ItemsEntity _sections = ItemsEntity(items: []);

  ItemsEntity get sections => _sections;
  Item _selectedStage = Item(name: null, id: null);
  Timer? _timer;
  RecordState _recordingStatus = RecordState.pause;

  RecordState? get recordingStatus => _recordingStatus;
  ValueNotifier<String> _recordingTime = ValueNotifier('00:0');

  ValueListenable<String>? get recordingTime => _recordingTime;

  ValueNotifier<int> _recordingSliderLength = ValueNotifier(0);

  ValueListenable<int>? get recordingSliderLength => _recordingSliderLength;

  File? _recordedFile;

  File? get recordedFile => _recordedFile;
  File? _selectedVideo;

  File? get selectedVideo => _selectedVideo;

  final Logger _logger = Logger('UploadLessonViewModel');
  Record _recorder = Record();
  List<File> _attachments = [];

  List<File> get attachments => _attachments;

  set selectedStage(Item selected) {
    _selectedStage = selected;
    getGrades();
    notifyListeners();
  }

  Item get selectedStage => _selectedStage;
  Item _selectedGrades = Item(name: null, id: null);

  List<Asset> _images = [];

  List<Asset> get images => _images;

  set selectedGrades(Item grades) {
    _selectedGrades = grades;
    getSubjects();
    getSections();

    notifyListeners();
  }

  Item get selectedGrades => _selectedGrades;

  Item _selectedSubject = Item(name: null, id: null);

  set selectedSubject(Item subject) {
    _selectedSubject = subject;
    notifyListeners();
  }

  Item get selectedSubject => _selectedSubject;
  Item _selectedSection = Item(name: null, id: null);

  set selectedSection(Item section) {
    _selectedSection = section;
    notifyListeners();
  }

  Item get selectedSection => _selectedSection;

  String _lessonTitle = '';

  set lessonTitle(String title) => _lessonTitle = title;
  String _lessonDetails = '';

  set lessonDetails(String details) => _lessonDetails = details;
  String _lessonExternalLink = '';

  set lessonExternalLink(String externalLink) =>
      _lessonExternalLink = externalLink;
  UploadLessonUseCase _uploadLessonUseCase;
  GetStagesUseCase _getStagesUseCase;
  GetGradesUseCase _gradesUseCase;
  GetSectionsUseCase _sectionsUseCase;
  GetSubjectsUseCase _subjectsUseCase;

  UploadLessonViewModel({
    required UploadLessonUseCase uploadLessonUseCase,
    required GetStagesUseCase getStagesUseCase,
    required GetGradesUseCase gradesUseCase,
    required GetSubjectsUseCase subjectsUseCase,
    required GetSectionsUseCase sectionsUseCase,
  })  : _uploadLessonUseCase = uploadLessonUseCase,
        _getStagesUseCase = getStagesUseCase,
        _gradesUseCase = gradesUseCase,
        _sectionsUseCase = sectionsUseCase,
        _subjectsUseCase = subjectsUseCase {
    getStages();
  }

  void getStages() async {
    _loading.value = true;
    final failureOrStages = await _getStagesUseCase();
    failureOrStages.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _stageEntity = r;
      notifyListeners();
    });
    _loading.value = false;
  }

  late String filePath;

  Future<void> getAudioFilePath() async {
    if (await _recorder.hasPermission()) {
      String dir = Platform.isIOS
          ? (await getApplicationDocumentsDirectory()).path
          : (await getExternalStorageDirectory())!.path;
      print("the path for audio is $dir");

      String formattedTime =
          'alawel${DateTime.now().millisecondsSinceEpoch.toString()}';
      filePath = dir + "/REC$formattedTime.m4a";

      print("the record path is $filePath");
    }
  }

  int _recordDuration = 0;
  void _startTimer() {
    _timer?.cancel();
    Duration tick = Duration(seconds: 1);

    _timer = new Timer.periodic(tick, (Timer t) async {
      _recordDuration++;
      _recordingTime.value = '${_recordDuration ~/ 60}:${_recordDuration % 60}';
      _recordingSliderLength.value = _recordDuration % 60 + 1;
      //notifyListeners();
    });
  }

  void startRecording() async {
    try {
      if (await _recorder.hasPermission()) {
        // We don't do anything with this but printing
        final isSupported = await _recorder.isEncoderSupported(
          AudioEncoder.aacLc,
        );
        if (kDebugMode) {
          print('${AudioEncoder.aacLc.name} supported: $isSupported');
        }

        // final devs = await _audioRecorder.listInputDevices();
        // final isRecording = await _audioRecorder.isRecording();

        await _recorder.start(
          path: filePath,
          encoder: AudioEncoder.aacLc, // by default
          bitRate: 128000, // by default
        );
        _startTimer();
        _recordingStatus = RecordState.record;
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // String appDocPath = appDocDir.path +
    //     'madaresco${DateTime.now().millisecondsSinceEpoch.toString()}';
    // var _hasPermission = await FlutterAudioRecorder3.hasPermissions;
    // if (_hasPermission == true) {
    //   // or AudioFormat.WAV
    //   _recorder = FlutterAudioRecorder3(appDocPath,
    //       audioFormat: AudioFormat.AAC, sampleRate: 22000);
    //   await _recorder!.initialized;
    //   await _recorder!.start();
    //   _recordingStatus = RecordState.record;
    //   notifyListeners();

    //   Duration tick = Duration(seconds: 1);

    //   _timer = new Timer.periodic(tick, (Timer t) async {
    //     var recording = await _recorder!.current(channel: 0);
    //     _recordingTime.value =
    //         '${recording!.duration!.inMinutes}:${recording.duration!.inSeconds}';
    //     _recordingSliderLength.value = recording.duration!.inSeconds + 1;
    //     //notifyListeners();
    //   });
    // }
  }

  void stopRecording() async {
    _timer!.cancel();
    _recordDuration = 0;
    var result = await _recorder.stop();
    _recordedFile = File(result!);

    notifyListeners();

    _logger.info(_recordedFile!.path);
    _recordingStatus = RecordState.stop;
  }

  void pickUpImages() async {
    List<Asset> resultList = [];
    const Color color = Color(0xff00B0FF);
    try {
      resultList = await MultiImagePicker.pickImages(
        // maxImages: 300,
        // enableCamera: true,
        selectedAssets: _images,
        cupertinoOptions: CupertinoOptions(
            doneButton: UIBarButtonItem(title: 'Confirm', tintColor: color),
            cancelButton:
                UIBarButtonItem(title: 'Cancel', tintColor: Colors.red),
            albumButtonColor: color),
        materialOptions: MaterialOptions(
          maxImages: 300,
          enableCamera: true,
          actionBarColor: color,
          actionBarTitle: "مدرسة الأوائل الأهلية",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: Colors.black,
        ),
      );
      _images = resultList;
      notifyListeners();
    } on Exception catch (e) {
      print("${e.toString()}");
    }
  }

  void pickUpVideo() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      //  allowedExtensions: ['mp4'],
    );
    _selectedVideo = result != null ? File(result.paths.first!) : null;
    _logger.info(_selectedVideo!.path);
    notifyListeners();
  }

  void pickUpAttachments() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    _attachments =
        result == null ? [] : result.paths.map((path) => File(path!)).toList();

    notifyListeners();
  }

  Future<bool?> addLesson() async {
    bool? result;
    if (_selectedStage.id == null) {
      _toast.value = Event('all_fields_requiered');
    } else {
      UploadLessonEntity uploadLessonEntity = UploadLessonEntity(
          name: _lessonTitle,
          description: _lessonDetails,
          externalLink: _lessonExternalLink,
          subjectId: _selectedSubject.id,
          sectionId: _selectedSection.id,
          video: _selectedVideo,
          attachments: _attachments,
          audio: _recordedFile,
          images: _images);
      _logger.info(
          'Section Id :${_selectedSection.id} SubjectId:${_selectedSubject.id}');

      _loading.value = true;
      final failureOrBool = await _uploadLessonUseCase(uploadLessonEntity);
      failureOrBool.fold((l) {
        _toast.value = Event(SERVER_FAILURE_MESSAGE);
        result = false;
      }, (r) {
        _logger.info(r);
        result = true;
      });

      _loading.value = false;
      return result;
    }
    return null;
  }

  void getGrades() async {
    _loading.value = true;
    final failureOrGrades = await _gradesUseCase(_selectedStage.id!);
    failureOrGrades.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _grades = r;
      notifyListeners();
    });
    _loading.value = false;
  }

  void getSections() async {
    _loading.value = true;
    final failureOrSections = await _sectionsUseCase(_selectedGrades.id!);
    failureOrSections.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _sections = r;
      notifyListeners();
    });
    _loading.value = false;
  }

  void getSubjects() async {
    _loading.value = true;
    final failureOrSubjects = await _subjectsUseCase(_selectedGrades.id!);
    failureOrSubjects.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _subjects = r;
      notifyListeners();
    });
    _loading.value = false;
  }

  void clearRecord() {
    _recordedFile = null;
    _recordingStatus = RecordState.pause;
    notifyListeners();
  }
}
