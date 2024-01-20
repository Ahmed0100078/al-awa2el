import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/MyProfile/presentation/manager/my_profile_view_model.dart';
import 'package:madaresco/features/OpeningScreen/OpeningScreen.dart';
import 'package:madaresco/features/TeacherOpeningScreen/teacher_opening_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../../main.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  bool _nameEnabled = false, _mailEnabled = false, _phoneEnabled = false;
  FocusNode? _nameNode, _mailNode, _phoneNode;

  @override
  void initState() {
    super.initState();
    _nameNode = FocusNode();
    _mailNode = FocusNode();
    _phoneNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    MyProfileViewModel vm = Provider.of<MyProfileViewModel>(context);
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
                height: 200,
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
                      local.translate('profile'),
                      style: GoogleFonts.cairo(
                          fontSize: 16.0, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 140,
              bottom: 0,
              right: 10,
              left: 10,
              child: Stack(clipBehavior: Clip.none, children: [
                Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  )),
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 100,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.0),
                                  border: Border.all(color: kAccentColor)),
                              height: 50,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      focusNode: _nameNode,
                                      enabled: _nameEnabled,
                                      onChanged: (value) {
                                        vm.name = value;
                                      },
                                      controller: vm.nameController,
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0.0, horizontal: 16.0),
                                        border: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  // InkWell(
                                  //   onTap: () {
                                  //     setState(() {
                                  //       _mailEnabled = false;
                                  //       _nameEnabled=true;
                                  //       _phoneEnabled=false;
                                  //       Future.delayed(const Duration(milliseconds: 10), () {
                                  //         FocusScope.of(context).requestFocus(_nameNode);
                                  //       });
                                  //     });
                                  //   },
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: Image.asset(
                                  //       'assets/images/edit.png',
                                  //       width: 16.0,
                                  //       height: 16.0,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              local.translate('email'),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  border: Border.all(color: kAccentColor)),
                              height: 50,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      enabled: _mailEnabled,
                                      focusNode: _mailNode,
                                      onChanged: (value) {
                                        vm.email = value;
                                      },
                                      controller: vm.emailController,
                                      style: TextStyle(
                                          color: kAccentColor,
                                          fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0.0, horizontal: 16.0),
                                        border: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _mailEnabled = true;
                                        _nameEnabled = false;
                                        _phoneEnabled = false;
                                        Future.delayed(
                                            const Duration(milliseconds: 10),
                                            () {
                                          FocusScope.of(context)
                                              .requestFocus(_mailNode);
                                        });
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/images/edit.png',
                                        width: 16.0,
                                        height: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              local.translate('phone'),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  border: Border.all(color: kAccentColor)),
                              height: 50,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      focusNode: _phoneNode,
                                      enabled: _phoneEnabled,
                                      onChanged: (value) {
                                        vm.phone = value;
                                      },
                                      controller: vm.phoneController,
                                      style: TextStyle(
                                          color: kAccentColor,
                                          fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0.0, horizontal: 16.0),
                                        border: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _mailEnabled = false;
                                        _nameEnabled = false;
                                        _phoneEnabled = true;
                                        Future.delayed(
                                            const Duration(milliseconds: 10),
                                            () {
                                          FocusScope.of(context)
                                              .requestFocus(_phoneNode);
                                        });
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/images/edit.png',
                                        width: 16.0,
                                        height: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextButton(
                            onPressed: () {
                              vm.editProfile(context);
                              _mailEnabled = false;
                              _nameEnabled = false;
                              _phoneEnabled = false;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF001068),
                                      Color(0xFF001068),
                                    ],
                                  )),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 50),
                              child: Text(
                                local.translate('edit_profile'),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  top: -40,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      padding: EdgeInsets.all(2.0),
                      child: Stack(alignment: Alignment.center, children: [
                        vm.image != null
                            ? CircleAvatar(
                                radius: 60.0,
                                backgroundImage:
                                    Image.file(File(vm.image!.path)).image,
                              )
                            : vm.entity!.image != ""
                                ? CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(vm.entity!.image),
                                    radius: 60.0,
                                  )
                                : CircleAvatar(
                                    backgroundImage: Image.asset(
                                            "assets/images/placeholder.png")
                                        .image,
                                    radius: 60.0,
                                  ),
                        // InkWell(
                        //   onTap: (){
                        //     vm.getImage(ImageSource.gallery);
                        //   },
                        //   child: Icon(
                        //     Icons.camera_alt,
                        //     color: Colors.white,
                        //     size: 40,
                        //   ),
                        // ),
                        // FlatButton.icon(
                        //     onPressed: () {
                        //       vm.getImage(ImageSource.gallery);
                        //     },
                        //     icon: Icon(
                        //       Icons.camera_alt,
                        //       color: Colors.white,
                        //       size: 40,
                        //     ),
                        //     label: SizedBox())
                      ]),
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
