import 'package:flutter/material.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/AllTeacher/domain/entities/all_teachers_entity.dart';
import 'package:madaresco/features/ChatWithPerson/presentation/manager/chat_view_model.dart';
import 'package:madaresco/injection_container.dart';
import 'package:madaresco/main.dart';
import 'package:provider/provider.dart';
import '../../../ChatWithPerson/presentation/pages/new_chat_page.dart';

class AllTeachersRow extends StatelessWidget {
  final Teachers item;

  AllTeachersRow({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
      child: Stack(clipBehavior: Clip.none, children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.grey)),
          child: Stack(
            children: <Widget>[
              Center(
                child: Text(
                  item.name,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                bottom: -6,
                right: 0,
                left: 0,
                child: ElevatedButton(
                  onPressed: () {
                    mainNavigatorKey.currentState!.push(
                      MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider(
                          create: (_) => sl<ChatViewModel>(),
                          child: NewChatPage(
                              url: 'users/${item.id}',
                              isLive: true,
                              name: item.name),
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0))),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      local.translate('send_now'),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned.fill(
          top: -40,
          child: Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(item.image),
            ),
          ),
        )
      ]),
    );
  }
}
