import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:madaresco/Util/healper/wedgets/custom_button.dart';
import 'package:madaresco/Util/healper/wedgets/custom_text_form_field.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/Register/presentation/manager/register_view_model.dart';
import 'package:madaresco/features/Register/presentation/pages/succesful_registration.dart';
import 'package:provider/provider.dart';
import 'package:queen_validators/queen_validators.dart';

class RegisterSchool extends StatefulWidget {
  @override
  State<RegisterSchool> createState() => _RegisterSchoolState();
}

class _RegisterSchoolState extends State<RegisterSchool> {
  GlobalKey<FormState> _form = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    RegisterViewModel vm = Provider.of<RegisterViewModel>(context);
    vm.toast.addListener(() {
      //   if (vm.toast.value.getContentIfNotHandled() != null) {
      if (vm.toast.value.peekContent() == SERVER_FAILURE_MESSAGE) {
        Fluttertoast.showToast(msg: SERVER_FAILURE_MESSAGE);
      } else {
        Fluttertoast.showToast(
            //  msg: local.translate(
            msg: vm.toast.value.peekContent()
            //)
            );
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
          /// User name text form field
          CustomTextFormField(
            onChange: (value) {
              vm.name = value;
            },
            hintError: local.translate('uname_error'),
            hint: local.translate('school_name'),
          ),
          SizedBox(
            height: 16.0,
          ),
          /// User country text form field
          CustomTextFormField(
            onChange: (value) {
              vm.country = value;
            },
            hintError: local.translate('country_error'),
            hint: local.translate('country'),
          ),
          SizedBox(
            height: 16.0,
          ),
          /// User city text form field
          CustomTextFormField(
            onChange: (value) {
              vm.city = value;
            },
            hintError: local.translate('city_error'),
            hint: local.translate('city'),
          ),
          SizedBox(
            height: 16.0,
          ),
          /// User Address text form field
          CustomTextFormField(
            onChange: (value) {
              vm.address = value;
            },
            hintError: local.translate('address_error'),
            hint: local.translate('address'),
          ),
          SizedBox(
            height: 16.0,
          ),
          /// User manager name text form field
          CustomTextFormField(
            onChange: (value) {
              vm.managerName = value;
            },
            hintError: local.translate('manager_name_error'),
            hint: local.translate('manager_name'),
          ),
          SizedBox(
            height: 16.0,
          ),
          /// User Email text form field
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
          SizedBox(
            height: 16.0,
          ),

          /// User Phone text form field
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
          CustomTextFormField(
            onChange: (value) {
              vm.password = value;
            },
            hintError: local.translate('pass_error'),
            hint: local.translate('pass'),
          ),
          SizedBox(
            height: 20.0,
          ),
          CustomButton(
            onPress: () {
              if (_form.currentState!.validate()) {
                vm.registerSchool();
              }
            },
            text: local.translate('register'),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
