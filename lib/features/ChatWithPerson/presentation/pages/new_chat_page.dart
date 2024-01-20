import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/ChatWithPerson/presentation/manager/chat_view_model.dart';
import 'package:madaresco/features/ChatWithPerson/presentation/widgets/chat_row.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/Login/presentation/pages/login_page.dart';
import 'package:madaresco/features/OpeningScreen/OpeningScreen.dart';
import 'package:madaresco/features/TeacherOpeningScreen/teacher_opening_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

/// A Re Implementation of ChatPage Widget using flutter_hooks
class NewChatPage extends HookWidget {
  /// student/path
  final String url;

  /// other person's name
  final String name;

  final String? sectionName;
  final String? gradeName;

  /// can chat or not
  final isLive;

  const NewChatPage(
      {this.sectionName,
      this.gradeName,
      required this.url,
      this.isLive = false,
      this.name = ""});

  @override
  Widget build(BuildContext context) {
    /// Controllers
    final ScrollController _scrollController = useScrollController();
    final TextEditingController controller = useTextEditingController();

    /// Models
    final ChatViewModel vm = Provider.of<ChatViewModel>(context);
    final AppLocalizations local = AppLocalizations.of(context);
    final Logger _logger = Logger('ChatPage');

    /// State variables
    final model = useState<LoginModel?>(null);
    final studentId = useState<int?>(null);

    /// InitState
    useEffect(() {
      /// Subscriptions
      /// ---------1--------
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _logger.info('last');
          if (vm.entity.next != null) {
            vm.getChatByUser(true);
          }
        }
      });

      /// ---------2--------
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
      vm.url = url;

      /// Futures
      /// just pushing login back on errors/null values
      /// ---------1--------
      SharedPreference.getLoginModel().then((value) {
        if (value == null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage()));
        } else {
          model.value = value;

          /// ---------2--------
          SharedPreference.getStudentId().then((value) {
            studentId.value = value;
          }, onError: (_, __) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
          });
        }
      }, onError: (_, __) {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
      });
      return null;
    }, const []);

    /// Show Loading overlay if vm still is.
    return ValueListenableBuilder(
      /// vm loading value
      valueListenable: vm.loading,
      builder: (context, bool loading, child) =>
          ModalProgressHUD(inAsyncCall: loading, child: child!),
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
          flexibleSpace: Container(
              decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF001068),
                Color(0xFF001068),
              ],
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          )),
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
          actions: [
            isLive
                ? GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.0),
                      child: Icon(
                        local.locale!.languageCode == "en"
                            ? Icons.arrow_back_ios
                            : Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ))
                : SizedBox.shrink()
          ],
          centerTitle: true,
          title: FittedBox(
            child: Text.rich(
              TextSpan(
                text: url == 'adminstration-room'
                    ? local.translate('contact_managment')
                    : name,
                style: GoogleFonts.cairo(
                    fontSize: 16.0, fontWeight: FontWeight.normal),
                children: [
                  TextSpan(
                    text:
                        '${gradeName != null ? '\n$gradeName' : ''}${sectionName != null ? ' - $sectionName' : ''}',
                    style: TextStyle(fontSize: 11),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                child: AnimatedList(
                  reverse: true,
                  key: vm.listKey,
                  controller: _scrollController,
                  itemBuilder: (context, index, animation) {
                    if (index >= vm.entity.message!.length) {
                      return ValueListenableBuilder(
                          valueListenable: vm.paginationLoading,
                          builder: (context, bool pLoading, child) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Opacity(
                                  opacity: pLoading ? 1.0 : 00,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                          });
                    } else {
                      return ChatRow(
                          studentId: studentId.value ?? 0,
                          message: vm.entity.message![index],
                          model: model.value!,
                          animation: animation);
                    }
                  },
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              //send message row
              Visibility(
                visible: (model.value?.type == "teacher" &&
                    url == "adminstration-room"),
                replacement: Padding(
                  padding: EdgeInsets.only(
                      right: 5,
                      left: 5,
                      bottom: MediaQuery.of(context).viewInsets.bottom == 0
                          ? MediaQuery.of(context).viewPadding.bottom
                          : 0),
                  child: Row(
                    children: <Widget>[
                      // message text field
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey)),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  controller: controller,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText:
                                          local.translate('write_message'),
                                      hintStyle: TextStyle(color: Colors.grey)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //send button
                      TextButton(
                          onPressed: () {
                            vm.sendMessage(controller.text, vm.entity.roomId!);
                            controller.clear();
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: kAccentColor, shape: BoxShape.circle),
                            child: Image.asset(
                              'assets/images/send.png',
                              height: 20,
                            ),
                          ),),
                    ],
                  ),
                ),
                child: SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
