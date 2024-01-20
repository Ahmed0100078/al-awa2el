import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/core/widgets/error_dialog_widget.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/Register/domain/entities/item_entity.dart';
import 'package:madaresco/features/Register/presentation/manager/register_view_model.dart';
import 'package:madaresco/features/Register/presentation/pages/succesful_registration.dart';
import 'package:provider/provider.dart';
import 'package:queen_validators/queen_validators.dart';
import '../../../../Util/healper/wedgets/custom_text_form_field.dart';

class RegisterTeacher extends StatefulWidget {
  @override
  _RegisterTeacherState createState() => _RegisterTeacherState();
}

class _RegisterTeacherState extends State<RegisterTeacher> {
  GlobalKey<FormState> _form = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    RegisterViewModel vm = Provider.of<RegisterViewModel>(context);
    vm.toast.addListener(() {
      // if (vm.toast.value.getContentIfNotHandled() != null) {
      if (vm.toast.value.peekContent() == SERVER_FAILURE_MESSAGE) {
        Fluttertoast.showToast(msg: SERVER_FAILURE_MESSAGE);
      } else {
        Fluttertoast.showToast(msg: vm.toast.value.peekContent());
        // local.translate(vm.toast.value.peekContent()));
      }
      // }
    });
    vm.navigateTo.addListener(() {
      if (vm.navigateTo.value.getContentIfNotHandled() != null) {
        if (vm.navigateTo.value.peekContent() == 'Student') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SuccesfulRegistration(message: 'student_message'),
            ),
            ModalRoute.withName("/Home"),
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SuccesfulRegistration(message: 'school_message'),
            ),
            ModalRoute.withName("/Home"),
          );
        }
      }
    });
    return Form(
      key: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 26.0,
          ),

          Text(
            local.translate('choose_school'),
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
              borderRadius: BorderRadius.circular(26.0),
              border: Border.all(color: Colors.grey),
            ),
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: DropdownButton<Item>(
                value: vm.selectedSchool.id == null ? null : vm.selectedSchool,
                hint: Text(
                  local.translate('choose_school'),
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
                  vm.selectedSchool = newValue!;
                },
                items:
                    vm.schools.items!.map<DropdownMenuItem<Item>>((Item value) {
                  return DropdownMenuItem<Item>(
                    value: value,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(value.name!),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return local.translate('uname_error');
              }
              return null;
            },
            onChanged: (value) {
              vm.name = value;
            },
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26.0),
                    borderSide: BorderSide(color: Colors.grey)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26.0),
                    borderSide: BorderSide(color: Colors.grey)),
                hintText: local.translate('teacher_name'),
                hintStyle: TextStyle(color: Colors.grey)),
          ),
          SizedBox(
            height: 16.0,
          ),
          CustomTextFormField(
            onChange: (value) {
              vm.email = value;
            },
            validator: qValidator([
              // if the textField contains value the rest of the validators
              // will run else it will pass alidation with checking them
              IsRequired(),

              /// the input value must be a
              /// valid (`well formatted`) email address
              const IsEmail(),
            ]),
            hintError: local.translate('email_error'),
            hint: local.translate('email'),
          ),
          // SizedBox(
          //   height: 16.0,
          // ),

          // TextFormField(
          //   onChanged: (value) {
          //     vm.email = value;
          //   },
          //   decoration: InputDecoration(
          //       contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(26.0),
          //           borderSide: BorderSide(color: Colors.grey)),
          //       enabledBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(26.0),
          //           borderSide: BorderSide(color: Colors.grey)),
          //       hintText: local.translate('email'),
          //       hintStyle: TextStyle(color: Colors.grey)),
          // ),

          SizedBox(
            height: 16.0,
          ),
          CustomTextFormField(
            onChange: (value) {
              vm.phone = value;
            },
            hintError: local.translate('phone_error'),
            hint: local.translate('phone'),
          ),

          SizedBox(
            height: 16.0,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return local.translate('pass_error');
              }
              return null;
            },
            onChanged: (value) {
              vm.password = value;
            },
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(26.0),
                  borderSide: BorderSide(color: Colors.grey)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(26.0),
                  borderSide: BorderSide(color: Colors.grey)),
              hintText: local.translate('pass'),
              hintStyle: TextStyle(color: Colors.grey),
            ),
            obscureText: true,
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26.0),
              border: Border.all(color: Colors.grey),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        local.translate('upload_photo'),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        vm.getImage(ImageSource.gallery);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(16.0)),
                        padding: EdgeInsets.all(16.0),
                        child: Icon(Icons.add, color: kAccentColor),
                      ),
                    ),
                  ],
                ),
                vm.image != null
                    ? Column(
                        children: <Widget>[
                          SizedBox(
                            height: 16.0,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.file(
                              File(vm.image!.path),
                              fit: BoxFit.fitWidth,
                              height: 200,
                            ),
                          ),
                        ],
                      )
                    : SizedBox()
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90.0),
            child: ElevatedButton(
              onPressed: () {
                if (_form.currentState!.validate()) {
                  if (vm.selectedSchool.id == null) {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                            child: errorDialogWidget(context,
                                local.translate('Please_choose_the_school'))));
                  } else if (vm.image == null) {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                            child: errorDialogWidget(context,
                                local.translate('upload_photo_desc'))));
                  } else {
                    vm.registerTeacher();
                  }
                }
              },
               style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              OutlinedBorder>(
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
                    borderRadius: BorderRadius.all(Radius.circular(87.0))),
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Center(
                    child: Text(local.translate('register'),
                        style: TextStyle(fontSize: 20))),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
