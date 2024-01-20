import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/MyProfile/domain/entities/edit_profile_entity.dart';
import 'package:madaresco/features/MyProfile/domain/entities/my_profile_entity.dart';
import 'package:madaresco/features/MyProfile/domain/use_cases/edit_profile_use_case.dart';
import 'package:madaresco/features/MyProfile/domain/use_cases/get_my_profile_use_case.dart';
import '../../../../core/language/app_loclaizations.dart';

class MyProfileViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));
  ValueNotifier<Event<String>> get toast => _toast;
  MyProfileEntity? _entity =
      MyProfileEntity(name: '', image: '', phone: '', email: '');
  EditProfileEntity? _profileEntity;
  String _name = '';
  String _email = '';
  String _phone = '';

  set name(String n) => _name = n;
  set email(String e) => _email = e;
  set phone(String p) => p;

  MyProfileEntity ?get entity => _entity;
  GetMyProfileUseCase _myProfileUseCase;
  EditProfileUseCase _editProfileUseCase;
  final Logger _logger = Logger('MYProfileViewModel');
  XFile ?_image;
  TextEditingController nameController =TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController phoneController =TextEditingController();
  XFile ?get image => _image;

  MyProfileViewModel(
      {required GetMyProfileUseCase myProfileUseCase,
      required EditProfileUseCase editProfileUseCase})
      : _myProfileUseCase = myProfileUseCase,
        _editProfileUseCase = editProfileUseCase {
    getProfile();
  }

  void getProfile() async {
    _loading.value = true;
    final failureOrProfile = await _myProfileUseCase();
    failureOrProfile.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _entity = r;
      nameController.text=entity!.name;
      emailController.text=entity!.email;
      phoneController.text=entity!.phone;
      _name = _entity!.name;
      _email = _entity!.email;
      _phone = _entity!.phone;
      notifyListeners();
    });
    _loading.value = false;
  }

  void editProfile(BuildContext context) async {
    var local = AppLocalizations.of(context);
    _profileEntity = EditProfileEntity(
        name: _name,
        phone: _phone,
        email: _email,
        image: _image != null ? File(_image!.path) :File('')
    );
    _logger.info(
        'Name ${_profileEntity!.name} Email ${_profileEntity!.email} phone ${_profileEntity!.phone}');
    _loading.value = true;
    final failureOrProfile = await _editProfileUseCase(_profileEntity!);
    failureOrProfile.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _entity = r;
      Fluttertoast.showToast(msg: local.translate("profileUpdateDone"));
      notifyListeners();
    });
    _loading.value = false;
  }

  Future getImage(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(source: source, maxWidth: 500, maxHeight: 500);
    _image = image;
    notifyListeners();
  }
}
