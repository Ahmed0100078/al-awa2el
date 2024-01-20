import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/features/ChatWithPerson/domain/entities/chat_entity.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import '../../../../Util/date_formatter.dart';

class ChatRow extends StatefulWidget {
  final MessageEntity _message;
  final LoginModel _model;
  final int _studentId;
  final Animation<double> _animation;

  ChatRow(
      {required MessageEntity message,
      required LoginModel model,
      required int studentId,
      required Animation<double> animation})
      : _message = message,
        _model = model,
        _studentId = studentId,
        _animation = animation;

  @override
  _ChatRowState createState() => _ChatRowState();
}

class _ChatRowState extends State<ChatRow> {
  int currentId = 0;
  @override
  void initState() {
    if (widget._studentId != 0) {
      currentId = widget._studentId;
    } else {
      currentId = widget._model.data!.id!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final offsetAnimation = currentId == widget._message.senderId
        ? Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
            .animate(widget._animation)
        : Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
            .animate(widget._animation);
    return SlideTransition(
      position: offsetAnimation,
      child: getRow(currentId, widget._message),
    );
  }

  Widget getRow(int currentId, MessageEntity message) {
    final createdAt = TextSpan(
        text:
            '\n${widget._message.createdAt == null ? ' . . . ' : dateFormatter(widget._message.createdAt!)}',
        style: TextStyle(color: Colors.grey, fontSize: 12));
    return currentId == message.senderId
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(widget._message.image),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: kAccentColor,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Text.rich(
                      TextSpan(
                          text: widget._message.message,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          children: [createdAt]),
                    ),
                  ),
                )
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.grey)),
                    child: Text.rich(TextSpan(
                        text: widget._message.message,
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                        children: [createdAt])),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(widget._message.image),
                ),
              ],
            ),
          );
  }
}
