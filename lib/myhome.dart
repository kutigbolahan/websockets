import 'dart:async';
import 'dart:convert';

import 'package:adhara_socket_io/adhara_socket_io.dart';
// import 'package:adhara_socket_io/manager.dart';
// import 'package:adhara_socket_io/socket.dart';
//import 'package:adhara_socket_io/options.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String status = 'null';

  // final SocketIO socketIO = SocketIO();

  // @override
  // void initState() {
  //   super.initState();
  //   initPlatformState();
  // }

  // // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   //define query params
  //   final query = Map<String, dynamic>();
  //   // query['token'] = "k123s_asks1221aksak";

  //   socketIO.on(SocketIO.defaultEvents.connect, (data) {
  //     setState(() {
  //       status = "connected to socketIO server";
  //     });
  //   });
  //   // socketIO.emit(eventName: 'message', data: m.text);

  //   socketIO.on(SocketIO.defaultEvents.error, (data) {
  //     print("error ${data.toString()}");
  //     setState(() {
  //       status = "error ${data.toString()}";
  //       print("error ${data.toString()}");
  //     });
  //   });

  //   socketIO.on('on-notification', (data) {
  //     print("error ${data.toString()}");
  //   });

  //   socketIO.connect(host: 'https://api.empl-dev.site', query: query);
  //   //add listeners
  //   // next add your listeners with your event names
  //   //the eventNames "connect","disconnect" and "error" are added by default, you don't need to do socketIO.on("disconnect"), socketIO.on("connect"), socketIO.on("error");

  //   // emit
  //   // socketIO.emit(
  //   //     eventName: "myLocation",
  //   //     data: {"latitude": -12.32033, "longitude": 74.012131});

  //   // socketIO.disconnect(); // disconnect from socketIO server

  //   Timer(Duration(seconds: 5), () {
  //     socketIO.disconnect();
  //   });
  // }

  // @override
  // void dispose() {
  //   socketIO.disconnect();
  //   super.dispose();
  // }

  List<String> toPrint = ["trying to conenct"];
  SocketIOManager manager;
  dynamic socket;
  bool isProbablyConnected = false;
  String url = 'https://api.empl-dev.site';
  //String channel = IOWebSocketChannel.connect('ws://echo.websocket.org');

  @override
  void initState() {
    super.initState();
    manager = SocketIOManager();
    //  initSocket();
  }

  // initSocket1() {
  //   IO.Socket socket = IO.io(url, <String, dynamic>{
  //     'transports': ['websocket'],
  //     'autoConnect': false,
  //   });
  //   socket.connect();
  //   socket.emit('/test', 'test');
  //   socket.send('args');
  // }

  initSocket() async {
    setState(() => isProbablyConnected = true);
    socket = await manager.createInstance(SocketOptions(
        //Socket IO server URI
        url,
        //Query params - can be used for authentication
        query: {
          "auth": "--SOME AUTH STRING---",
          "info": "new connection from adhara-socketio"
        },
        //Enable or disable platform channel logging
        enableLogging: false,
        transports: [Transports.WEB_SOCKET, Transports.POLLING]));
    socket.onConnect((data) {
      pprint("connected...");
      pprint(data);
      sendMessage();
    });
    socket.onConnectError(pprint);
    socket.onConnectTimeout(pprint);
    socket.onError(pprint);
    socket.onDisconnect(pprint);
    socket.on("ExampleEvent", (data) {
      pprint("news");
      pprint(data);
    });
    socket.connect();
  }

  disconnect() {
    manager.clearInstance(socket);
    setState(() => isProbablyConnected = false);
  }

  sendMessage() {
    if (socket != null) {
      pprint("sending message...");
      socket.emit("ExampleEvent", [
        "Hello worldghuhdryfgykhhvgf!",
        1908,
        {
          "wonder": "Woman",
          "comics": ["DC", "Marvel"]
        },
        {"test": "=!./"},
        [
          "I'm glad",
          2019,
          {
            "come back": "Tony",
            "adhara means": ["base", "foundation"]
          },
          {"test": "=!./"},
        ]
      ]);
      pprint("Message emitted...");
    }
  }

  pprint(data) {
    setState(() {
      if (data is Map) {
        data = json.encode(data);
      }
      print(data);
      toPrint.add(data);
    });
  }

  TextEditingController m = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adhara Socket.IO example'),
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body:
          // Center(
          //   child: Column(children: [
          //     TextField(
          //       controller: m,
          //     ),
          //     RaisedButton(
          //       onPressed: () {
          //         initPlatformState();
          //       },
          //       child: Text('data'),
          //     ),
          //     Text('$status\n')
          //   ]),
          // ),
          Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Expanded(
            //     child: Center(
            //   child: ListView(
            //     children: toPrint.map((String _) => Text(_ ?? "")).toList(),
            //   ),
            // )),
            Column(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: RaisedButton(
                    child: Text("Connect"),
                    onPressed: isProbablyConnected ? null : initSocket,
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    child: RaisedButton(
                      child: Text("Send Message"),
                      onPressed: sendMessage,
                    )),
              ],
            ),
            SizedBox(
              height: 12.0,
            )
          ],
        ),
      ),
    );
  }
}
