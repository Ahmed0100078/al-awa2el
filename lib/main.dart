import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:madaresco/features/AboutApp/presentation/manager/about_app_view_model.dart';
import 'package:madaresco/features/DeskForm/presentation/manager/desk_form_cubit/desk_form_cubit.dart';
import 'package:madaresco/features/DeskForm/presentation/manager/grades_cubit/grades_cubit.dart';
import 'package:madaresco/features/EmploymentForm/presentation/manager/employment_form_cubit/employment_form_cubit.dart';
import 'package:madaresco/features/StudentApplicationForm/presentation/manager/get_schools_cubit/get_schools_cubit.dart';
import 'package:madaresco/features/TeacherRooms/presentation/manager/get%20Grades%20cubit/getgrades_cubit.dart';
import 'package:madaresco/features/TeacherRooms/presentation/manager/get%20sections%20cubit/get_sections_cubit.dart';
import 'package:madaresco/features/TeacherRooms/presentation/manager/getFilterd%20students%20cubit/getfilterdstudents_cubit.dart';
import 'package:provider/provider.dart';

import 'Util/healper/get_and_save/device_id.dart';
import 'Util/healper/get_and_save/fcm_token.dart';
import 'core/Network/network.dart';
import 'core/constant.dart';
import 'core/language/AppLanguage.dart';
import 'core/language/app_loclaizations.dart';
import 'core/language/ku_material_localization_delegate.dart';
import 'core/language/ku_widget_localization_delegate.dart';
import 'core/notification_handler.dart';
import 'features/Splash/splash.dart';
import 'features/StudentApplicationForm/presentation/manager/student_form_cubit/student_app_form_cubit.dart';
import 'features/TeacherRooms/data/data_sources/teachers_rooms_data_source.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

final GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

// todo : DiagnosticsMixin --> Diagnostics
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FlutterDownloader.registerCallback(DownloadClass.callback);
  // TODO: Use Firebase Analytics Correctly
  // ignore: unused_local_variable
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  getAndSaveDeviceID();
  getAndSaveFCMToken();

  /// Running simultaneously to lower run-time
  await Future.wait([
    appLanguage.fetchLocale(),
    di.init(),
    FlutterDownloader.initialize(
      debug: true,
      ignoreSsl: true,
    )
  ]);
  runApp(MyApp(
    appLanguage: appLanguage,
  ));

  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    log('${record.loggerName}:${record.message}',
        level: record.level.value, name: record.level.name, time: record.time);
  });
}

class MyApp extends StatefulWidget {
  final AppLanguage? appLanguage;

  MyApp({this.appLanguage});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _logger = Logger('MainClass');
  late Future<void> initializeFlutterFireFuture;

  // ReceivePort _port = ReceivePort();
  @override
  void initState() {
    super.initState();
    setupNotifications();
    // IsolateNameServer.registerPortWithName(
    //     _port.sendPort, 'downloader_send_port');
    // _port.listen((dynamic data) {
    //   String id = data[0];
    //   DownloadTaskStatus status = data[1];
    //   int progress = data[2];
    //   setState(() {});
    // });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetgradesCubit(
            TeachersRoomsRemoteDataSourceImpl(network: Network()),
          ),
        ),
        BlocProvider(
          create: (context) => GetSectionsCubit(
            TeachersRoomsRemoteDataSourceImpl(network: Network()),
          ),
        ),
        BlocProvider(
          create: (context) => GetfilterdstudentsCubit(
            TeachersRoomsRemoteDataSourceImpl(network: Network()),
          ),
        ),
        BlocProvider(create: (context) => StudentAppFormCubit()),
        BlocProvider(create: (context) => GetSchoolsCubit()),
        BlocProvider(create: (context) => EmploymentFormCubit()),
        BlocProvider(create: (context) => DeskFormCubit()),
        BlocProvider(create: (context) => GradesCubit()),
      ],
      child: ChangeNotifierProvider<AboutAppViewModel>(
        create: (_) => sl<AboutAppViewModel>(),
        child: ChangeNotifierProvider<AppLanguage>(
          create: (_) => widget.appLanguage!,
          child: Consumer<AppLanguage>(builder: (context, model, child) {
            locale.value = model.appLocal;
            _logger.info(locale.value.languageCode);
            return MaterialApp(
              title: "مدرسة الأوائل الأهلية",
              navigatorKey: mainNavigatorKey,
              locale: model.appLocal,
              debugShowCheckedModeBanner: false,
              supportedLocales: [
                Locale('en', 'US'),
                Locale('ar', ''),
                Locale('ku', '')
              ],
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                KuMaterialLocalizations.delegate,
                KuWidgetLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultWidgetsLocalizations.delegate,
              ],
              theme: ThemeData(
                // useMaterial3: true,
                textTheme: GoogleFonts.cairoTextTheme(
                  Theme.of(context).textTheme,
                ),
              ),
              home: Splash(),
            );
          }),
        ),
      ),
    );
  }
}
