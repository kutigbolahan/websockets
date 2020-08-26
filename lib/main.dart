import 'package:flutter/material.dart';
import 'package:websockets/home2.txt2';
import 'package:websockets/myhome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
          //  channel: IOWebSocketChannel.connect('ws://api.empl-dev.site'),
          ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   final WebSocketChannel channel;

//   MyHomePage({Key key, @required this.channel}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   TextEditingController _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('widget.title'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Form(
//               child: TextFormField(
//                 controller: _controller,
//                 decoration: InputDecoration(labelText: 'Send a message'),
//               ),
//             ),
//             StreamBuilder(
//               stream: widget.channel.stream,
//               builder: (context, snapshot) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 24.0),
//                   child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _sendMessage,
//         tooltip: 'Send message',
//         child: Icon(Icons.send),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }

//   void _sendMessage() {
//     if (_controller.text.isNotEmpty) {
//       widget.channel.sink.add(_controller.text);
//     }
//   }

//   @override
//   void dispose() {
//     widget.channel.sink.close();
//     super.dispose();
//   }
// }
