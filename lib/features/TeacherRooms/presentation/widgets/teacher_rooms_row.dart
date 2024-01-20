import 'package:flutter/material.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/ChatWithPerson/presentation/manager/chat_view_model.dart';
import 'package:madaresco/features/ChatWithPerson/presentation/pages/new_chat_page.dart';
import 'package:madaresco/features/TeacherRooms/data/models/Filterd%20studentsModel.dart';
import 'package:madaresco/injection_container.dart';
import 'package:provider/provider.dart';
import '../../../../main.dart';

// class TeacherRoomsRow extends StatelessWidget {
//   final Students item;
//
//   TeacherRoomsRow({
//     required this.item,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     var local = AppLocalizations.of(context);
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
//       child: Stack(clipBehavior: Clip.none, children: [
//         Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20.0),
//               border: Border.all(color: Colors.grey)),
//           child: Stack(
//             children: <Widget>[
//               Center(
//                 child: Container(
//                   height: 50,
//                   width: MediaQuery.of(context).size.width * 0.8,
//                   child: Text(
//                     item.name,
//                     style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold),
//                     overflow: TextOverflow.clip,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: -6,
//                 right: 0,
//                 left: 0,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     mainNavigatorKey.currentState!.push(
//                       MaterialPageRoute(
//                         builder: (_) => ChangeNotifierProvider(
//                           create: (_) => sl<ChatViewModel>(),
//                           child: ChatPage(url: 'rooms/${item.id}',isLive: true),
//                         ),
//                       ),
//                     );
//                   },
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16.0),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(5.0),
//                     child: Text(
//                       local.translate('send_now'),
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//         Positioned.fill(
//           top: -40,
//           child: Align(
//             alignment: Alignment.topCenter,
//             child: CircleAvatar(
//               radius: 40,
//               backgroundImage: NetworkImage(item.image),
//             ),
//           ),
//         )
//       ]),
//     );
//   }
// }

class FilterTeacherRoomsRow extends StatelessWidget {
  final Student item;

  FilterTeacherRoomsRow({
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
                child: Container(
                  // height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    item.name!,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                  ),
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
                            name: item.name ?? "",
                            gradeName: item.section?.grade?.name,
                            sectionName: item.section?.name,
                          ),
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
          top: -45,
          child: Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(item.avatar!),
            ),
          ),
        )
      ]),
    );
  }
}
