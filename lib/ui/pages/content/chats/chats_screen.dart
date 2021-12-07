import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:retociclo4/domain/models/chat_messages.dart';
import 'package:retociclo4/domain/use_cases/controllers/auth_controller.dart';
import 'package:retociclo4/domain/use_cases/controllers/chats_controller.dart';
import 'package:retociclo4/domain/use_cases/controllers/conectivity_controller.dart';

final databaseReference = FirebaseDatabase.instance.reference();

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late TextEditingController _textController;
  late ScrollController _scrollController;
  ConnectivityController connectivityController = Get.find<ConnectivityController>();
  AuthController authController = Get.find<AuthController>();
  ChatController chatController = Get.find();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _scrollController = ScrollController();
    chatController.start();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    chatController.stop();
    super.dispose();
  }

  Widget _item(Message element, int posicion, String uid) {
    logInfo('Current user? -> ${uid == element.user} msg -> ${element.text}');
    return Card(
      margin: EdgeInsets.all(4.0),
      color: uid == element.user ? Colors.yellow[200] : Colors.grey[300],
      child: ListTile(
        onTap: () => chatController.updateMsg(element),
        onLongPress: () => chatController.deleteMsg(element, posicion),
        title: Text(
          element.text,
          textAlign: uid == element.user ? TextAlign.right : TextAlign.left,
        ),
      ),
    );
  }

  Widget _list() {
    User user = authController.currentUser!;
    String uid = user.uid;
    print('Current user $uid');
    return GetX<ChatController>(builder: (controller) {
      WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToEnd());
      return ListView.builder(
        itemCount: chatController.messages.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          log('${chatController.messages}');
          var element = chatController.messages[index];
          return _item(element, index, uid);
        },
      );
    });
  }

  Future<void> _sendMsg(String text) async {
    //FocusScope.of(context).requestFocus(FocusNode());
    logInfo("Calling _sendMsg with $text");
    await chatController.sendMsg(text);
  }

  Widget _textInput() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.only(left: 5.0, top: 5.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your message',
              ),
              onSubmitted: (value) {
                _sendMsg(_textController.text);
                _textController.clear();
              },
              controller: _textController,
            ),
          ),
        ),
        TextButton(
            child: Text('Send'),
            onPressed: () {
              _sendMsg(_textController.text);
              _textController.clear();
            })
      ],
    );
  }

  _scrollToEnd() async {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToEnd());
    return Container(
      child: Column(
        children: [Expanded(flex: 4, child: _list()), _textInput()],
      ),
    );
  }
}