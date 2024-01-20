import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/AllTeacher/presentation/manager/all_teachers_view_model.dart';
import 'package:madaresco/features/AllTeacher/presentation/pages/all_teachers_page.dart';
import 'package:madaresco/features/ChatWithPerson/presentation/manager/chat_view_model.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/Main/presentation/manager/MainViewModel.dart';
import 'package:madaresco/features/Main/presentation/pages/main_student_page.dart';
import 'package:madaresco/features/SchoolNews/presentation/manager/school_news_view_model.dart';
import 'package:madaresco/features/SchoolNews/presentation/pages/school_news_page.dart';
import 'package:madaresco/features/SideMenu/side_menu.dart';
import 'package:madaresco/features/TeacherOpeningScreen/close_dialog.dart';
import 'package:provider/provider.dart';
import '../../injection_container.dart';
import '../../main.dart';
import '../ChatWithPerson/presentation/pages/new_chat_page.dart';

class OpeningScreen extends StatefulWidget {
  final bool isParent;
  OpeningScreen({this.isParent = false});
  @override
  _OpeningScreenState createState() => _OpeningScreenState();
}

final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

class _OpeningScreenState extends State<OpeningScreen>
    with SingleTickerProviderStateMixin {
  int index = 0;
  final endPoint = "https://school.awaelps.com/";

  sentLocation({double? lat, double? long}) async {
    LoginModel? model = await SharedPreference.getLoginModel();
    var header = {
      HttpHeaders.authorizationHeader: "Bearer ${model!.token}",
    };
    var data = {"lat": lat, "lng": long, "_method": "PUT"};
    Response res = await Dio().post("${endPoint}api/me/update",
        data: data, options: Options(headers: header));
    print(res.data);
  }

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await sentLocation(lat: position.latitude, long: position.longitude);
  }

  @override
  void initState() {
    super.initState();
    if (widget.isParent == false) {
      _determinePosition();
    }
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    final _items = [
      ChangeNotifierProvider(
          create: (_) => sl<MainViewModel>(), child: MainStudentPage()),
      ChangeNotifierProvider(
        create: (_) => sl<ChatViewModel>(),
        child: NewChatPage(url: 'adminstration-room', name: ""),
      ),
      ChangeNotifierProvider(
          create: (_) => sl<AllTeachersViewModel>(), child: AllTeachersPage()),
      ChangeNotifierProvider(
        create: (_) => sl<SchoolNewsViewModel>(),
        child: SchoolNewsPage(withBack: false),
      ),
    ];

    List<BottomNavigationBarItem> navItems = [
      BottomNavigationBarItem(
        icon: Image.asset(
          'assets/images/stayhome.png',
          height: 19,
          width: 19,
          color: index == 0 ? kAccentColor : Colors.black,
        ),
        label: local.translate('home'),
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          'assets/images/technical.png',
          width: 19,
          height: 19,
          color: index == 1 ? kAccentColor : Colors.black,
        ),
        label: local.translate('contact_managment'),
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          'assets/images/support.png',
          width: 20,
          height: 20,
          color: index == 2 ? kAccentColor : Colors.black,
        ),
        label: local.translate('contact_teachers'),
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          'assets/images/newspaper.png',
          width: 20,
          height: 20,
          color: index == 3 ? kAccentColor : Colors.black,
        ),
        label: local.translate('school_news'),
      ),
    ];
    return WillPopScope(
      onWillPop: () async {
        bool lastPage = await mainNavigatorKey.currentState!.maybePop();
        if (!lastPage) {
          bool result = await showCloseDialog(context);
          return result;
        } else {
          if (ModalRoute.of(context)!.isFirst) {
            getNotifications.value = Event(true);
          }
          return false;
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        drawer: SideMenu(),
        // body: CustomNavigator(
        //   home: _items[index],
        //   pageRoute: PageRoutes.materialPageRoute,
        //   navigatorKey: navigatorKey,
        // ),
        body: _items[index],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) async {
            //mainNavigatorKey.currentState!.popUntil((route) => route.isFirst);
            getNotifications.value = Event(true);
            setState(() {});
            this.index = index;
          },
          items: navItems,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black,
          selectedItemColor: kAccentColor,
          currentIndex: index,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  void setIndex(int index) {
    this.index = index;
    mainNavigatorKey.currentState!.maybePop();
    setState(() {});
  }

  Future<dynamic> showCloseDialog(BuildContext context) async {
    Dialog alertDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: CloseDialog(),
    );
    var close = await showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return ScaleTransition(scale: a1, child: alertDialog);
        },
        transitionDuration: Duration(milliseconds: 250),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return SizedBox();
        });
    return close;
  }
}
