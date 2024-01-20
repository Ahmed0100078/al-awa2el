import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:madaresco/Util/Event.dart' as ev;
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/features/ChatWithPerson/data/models/chat_model.dart';
import 'package:madaresco/features/ChatWithPerson/domain/entities/chat_entity.dart';
import 'package:madaresco/features/ChatWithPerson/domain/use_cases/get_chat_use_case.dart';
import 'package:madaresco/features/ChatWithPerson/domain/use_cases/get_pusher_data_use_case.dart';
import 'package:madaresco/features/ChatWithPerson/domain/use_cases/send_message_use_case.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:pusher_client/pusher_client.dart';

class ChatViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<ev.Event<String>> _toast = ValueNotifier(ev.Event(''));

  ValueNotifier<ev.Event<String>> get toast => _toast;
  String? lastConnectionState;
  Channel? channel;

  ChatEntity _entity = ChatEntity(message: [], next: null, roomId: null);

  ChatEntity get entity => _entity;

  ValueNotifier<String> _url = ValueNotifier('');

  set url(String i) => _url.value = i;
  ValueNotifier<bool> _paginationLoading = ValueNotifier(false);

  ValueNotifier<bool> get paginationLoading => _paginationLoading;
  int _page = 1;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  GlobalKey<AnimatedListState> get listKey => _listKey;
  List<MessageEntity> _messages = [];

  int get page => _page;
  final Logger _logger = Logger('ChatViewModel');
  String socketId = '';
  ValueNotifier<int> roomId = ValueNotifier(0);
  PusherClient? pusher;
  bool pusherSubscribed = false;

  GetChatUseCase _chatUseCase;
  SendMessageUseCase _sendMessageUseCase;
  GetPusherDataUseCase _pusherDataUseCase;

  ChatViewModel(
      {required GetChatUseCase chatUseCase,
      required SendMessageUseCase sendMessageUseCase,
      required GetPusherDataUseCase pusherDataUseCase})
      : _chatUseCase = chatUseCase,
        _sendMessageUseCase = sendMessageUseCase,
        _pusherDataUseCase = pusherDataUseCase {
    initPusher();
  }

  Future<void> initPusher() async {
    LoginModel? model = await SharedPreference.getLoginModel();
    _loading.value = true;
    final failureOrPusherData = await _pusherDataUseCase();
    failureOrPusherData.fold(
        (l) => _toast.value = ev.Event(SERVER_FAILURE_MESSAGE), (r) async {
      try {
        pusher = PusherClient(
            "tHhoTj90dy",
            PusherOptions(
              encrypted: true,
              host: 'elnooronline.club',
              wsPort: 6001,
              wssPort: 6001,
              auth: PusherAuth('${Network().baseEndPoint}broadcasting/auth',
                  headers: {'Authorization': 'Bearer ${model!.token}'}),
            ),
            enableLogging: true);
        connectPusher();
        _loading.value = false;
      } on PlatformException catch (e) {
        print(e.message);
      }
    });
  }

  void pusherSubscribe(ChatEntity entity) async {
    channel = pusher!.subscribe('presence-chat.${entity.roomId}');
    pusherSubscribed = true;
    socketId = pusher!.getSocketId().toString();
    roomId.value = entity.roomId!;
    notifyListeners();
    _logger.info(socketId);
    await channel!.bind('App\\Events\\ConversationSent', (x) {
      _logger.info(json.decode(x!.data!));
      var message = ChatData.fromJson(jsonDecode(x.data!));
      _entity.message!.insert(0, message);
      _listKey.currentState!
          .insertItem(0, duration: Duration(milliseconds: 200));
      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    channel!.unbind("App\\Events\\ConversationSent");
    pusher!.unsubscribe('presence-chat.${_entity.roomId}');
    pusher!.disconnect();
    pusherSubscribed = false;
  }

  void connectPusher() async {
    getChatByUser();

    pusher!.connect();
    pusher!.onConnectionStateChange((state) async {
      lastConnectionState = state!.currentState!;
      _logger.info(lastConnectionState);
      if (state.currentState == 'CONNECTED') {}
    });
    pusher!.onConnectionError((error) {
      debugPrint("Error: ${error!.message}");
    });
  }

  void getChatByUser([bool pagination = false]) async {
    pagination ? _paginationLoading.value = true : _loading.value = true;
    final failureOrGallarys = await _chatUseCase(_url.value, page);
    failureOrGallarys
        .fold((l) => _toast.value = ev.Event(SERVER_FAILURE_MESSAGE), (r) {
      if (!pusherSubscribed) {
        pusherSubscribe(r);
      }
      if (pagination) {
        _entity.message!.addAll(r.message!);
        _entity.next = r.next;
        for (int i = 0; i < r.message!.length; i++) {
          _listKey.currentState!
              .insertItem(i, duration: Duration(milliseconds: 200));
        }
      } else {
        _entity = r;
        for (int i = 0; i < r.message!.length; i++) {
          _listKey.currentState!
              .insertItem(i, duration: Duration(milliseconds: 200));
        }
      }

      if (r.next != null) {
        _page++;
      }
      notifyListeners();
    });
    pagination ? _paginationLoading.value = false : _loading.value = false;
  }

  void sendMessage(String message, int roomINumber) async {
    LoginModel? model = await SharedPreference.getLoginModel();
    int cStudentId = await SharedPreference.getStudentId();
    if (message.isNotEmpty) {
      var chatData = ChatData(
          sender: Sender(
              id: cStudentId != 0 ? cStudentId : model!.data!.id,
              avatar: model!.data!.avatar),
          message: message);
      _messages = _entity.message!;
      _messages.isNotEmpty
          ? _messages.insert(0, chatData)
          : _messages.add(chatData);
      _entity = _entity.copyWithProperties(message: _messages);
      _listKey.currentState!.insertItem(_entity.message!.indexOf(chatData),
          duration: Duration(milliseconds: 200));
      final failureOrMessage =
          await _sendMessageUseCase(roomId.value, message, socketId);
      failureOrMessage.fold((l) {
        // return _toast.value = ev.Event(SERVER_FAILURE_MESSAGE);
      }, (r) {
        notifyListeners();
        _logger.fine(r.message);
      });
    }
  }
}
