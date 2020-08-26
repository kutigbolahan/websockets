import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:websockets/chat/chatbloc.dart';
import 'package:websockets/chat/chcontr.dart';
import 'package:websockets/chat/chite.dart';
import 'package:websockets/chat/const.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Socket socket;
  @override
  void initState() {
    super.initState();
    socket = io(MyAppConstants.serverBaseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider.value(
        value: socket,
        child: ProxyProvider<Socket, ChatBloc>(
          update: (context, socket, previousBloc) {
            return ChatBloc(Provider.of<Socket>(context));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ChatListWidget(),
              ),
              ChatControllerWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
