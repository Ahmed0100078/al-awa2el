import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/OpeningScreen/OpeningScreen.dart';
import 'package:madaresco/features/Supervisor/data/remote/models/Supervisor_model.dart';
import 'package:madaresco/features/Supervisor/presentation/pages/MapPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'custom_text_container.dart';

@override
class CustomCardCotnaienr extends StatelessWidget {
  final String childName;
  final String studentClass;
  final String schoolName;
  final String ?imgLink;
  final Student model;

  CustomCardCotnaienr(
      {required this.childName,
      required this.schoolName,
      required this.studentClass,
      required this.model,
      this.imgLink});
  final endPoint = "https://school.awaelps.com/";

  Future<String> getStudentToken(int id) async {
    LoginModel ?model = await SharedPreference.getLoginModel();
    var header = {
      HttpHeaders.authorizationHeader: "Bearer ${model!.token}",
    };
    Response res = await Dio().post("${endPoint}api/impersonate/$id",
        options: Options(headers: header));
    print(res.data);
    try {
      int studentId = res.data["data"]["id"];
      SharedPreference.setStudentId(studentId);
    }catch(e){}
    return res.data["token"];
  }

  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
        child: Container(
          height: 145,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 16,
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[350],
                backgroundImage: imgLink == null
                    ? NetworkImage('https://via.placeholder.com/150')
                    : NetworkImage(imgLink!),
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: <Widget>[
                      Text(
                        'اسم الابن :',
                        style: TextStyle(
                          color: kAccentColor,
                        ),
                      ),
                      Text(childName)
                    ],
                  ),
                  Text(schoolName),
                  Text(studentClass),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 200,
                    child: Center(
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: InkWell(
                              onTap: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                String token = await getStudentToken(model.id!);
                                prefs.setString("Ctoken", token);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => OpeningScreen(
                                            isParent: true,
                                          )),
                                );
                              },
                              child: CustomTextContainer(
                                  padding: EdgeInsets.only(left: 8),
                                  text: '${local.translate("dashboard")}'),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                if(model.location!.lat !=null && model.location!.lng !=null){
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MapPage(
                                        lat: double.parse(model.location!.lat),
                                        long: double.parse(model.location!.lng),
                                      )));
                                }else{
                                  Fluttertoast.showToast(
                                      msg: "${local.translate("noStudentLocation")}",
                                      toastLength: Toast.LENGTH_LONG);
                                }
                              },
                              child: CustomTextContainer(
                                  padding: EdgeInsets.only(right: 8),
                                  text: '${local.translate("trackSon")}'),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
