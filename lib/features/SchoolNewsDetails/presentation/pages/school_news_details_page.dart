import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/OpeningScreen/OpeningScreen.dart';
import 'package:madaresco/features/SchoolNews/data/models/school_news_model.dart';
import 'package:madaresco/features/SchoolNewsDetails/presentation/manager/school_news_details_view_model.dart';
import 'package:madaresco/features/SchoolNewsDetails/presentation/widgets/Galleryslider.dart';
import 'package:madaresco/features/TeacherOpeningScreen/teacher_opening_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../../main.dart';

class SchoolNewsDetailsPage extends StatelessWidget {
  final int _id;
  final List<Album> photos;

  const SchoolNewsDetailsPage({required int id, required this.photos})
      : _id = id;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    SchoolNewsDetailsViewModel vm =
        Provider.of<SchoolNewsDetailsViewModel>(context);
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
    vm.id = _id;
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          AspectRatio(
                            aspectRatio: 2.5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.network(
                                vm.entity.image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            vm.entity.title,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            vm.entity.description,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  vm.entity.date,
                                  style: TextStyle(
                                      color: kAccentColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Image.asset(
                                'assets/images/vision.png',
                                height: 8,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                vm.entity.number.toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.4,
                            padding: EdgeInsets.all(20.0),
                            child: GridView.count(
                              crossAxisCount: 2,
                              children: photos
                                  .map(
                                    (e) => GestureDetector(
                                      onTap: () async {
                                        mainNavigatorKey.currentState!
                                            .push(MaterialPageRoute(
                                                builder: (_) => GallarySlider(
                                                      intiialPage:
                                                          photos.indexOf(e),
                                                      images: photos,
                                                    )));
                                      },
                                      child: GridTile(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Image.network(
                                              e.link!,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
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
    );
  }
}
