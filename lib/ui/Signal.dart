import 'dart:io';

import 'package:android_util/android_ip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/src/provider.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:untitled1/provider/UploadProvider.dart';
import 'package:untitled1/service/Service.dart';
import 'package:untitled1/util/webserver.dart';

import '../main.dart';
import 'WebSocket.dart';

class Signal extends StatefulWidget {
  const Signal({Key? key}) : super(key: key);

  @override
  State<Signal> createState() => _SignalState();
}

var key = GlobalKey<ScaffoldState>();
var messageWidgets = [];
var _messageController = TextEditingController();
var _scrollController = ScrollController();
var _showfiles = [];
HubConnection? connection = HubConnectionBuilder()
    .withUrl(
        'http://192.168.52.156:$mfav_port/chat',
        HttpConnectionOptions(
          logging: (level, message) => print(message),
        ))
    .build();

class _SignalState extends State<Signal> {
  ShareService services = ShareService();
  var ip2 = "";
  var isde = false;

  @override
  initState() {
    super.initState();
    initHub();

    if (proces_txt.length > 0) _messageController.text = proces_txt;
  }

  var retry = 0;

  void initHub() {
    connection = HubConnectionBuilder()
        .withUrl(
            'http://${ip2}:$mfav_port/chat',
            HttpConnectionOptions(
              logging: (level, message) => print(message),
            ))
        .build();
    connection?.start()!.then((value) {
      context.read<UploadProvider>().isConnected = "Connected";
    }).onError((error, stackTrace) {
      context.read<UploadProvider>().isConnected = "Failed";
      retry++;
      if (retry < 5) SetSocket(context);

    });
    connection?.on('newMessage', (message) {
      print(message.toString());
      var length = messageWidgets.length;
      Widget padding2 = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                  onLongPress: () {
                    _copy(message![1]);
                  },
                  onDoubleTap: () {
                    setState(() {
                      messageWidgets.removeAt(length);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xDD1192D5),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Text("${message![1]}",
                            style: TextStyle(color: Colors.black87))
                      ],
                    ),
                  )),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      );
      setState(() {
        messageWidgets.add(padding2);
      });
    });
    connection?.on('newMessage2', (message) {
      if (my == "") {
        print(message.toString());
        var length = messageWidgets.length;
        Widget padding2 = Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                    onLongPress: () {
                      _copy(message![1]);
                    },
                    onDoubleTap: () {
                      setState(() {
                        messageWidgets.removeAt(length);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xDDCED9E2),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Text("${message![1]}",
                              style: TextStyle(color: Colors.black87))
                        ],
                      ),
                    )),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        );
        setState(() {
          messageWidgets.add(padding2);
        });
      } else {
        my = "";
      }
    });
  }
var my="";
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (connection != null) connection?.stop();
    connection = null;
  }

  @override
  Widget build(BuildContext context) {
    isde = context.watch<UploadProvider>().isde;
    // setLisIp();
    // ip2 = context.watch<UploadProvider>().ip;
    // if (ip2.toString().isNotEmpty) Uploadf(context);
    var children2 = [
      SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text("Message", style: TextStyle(color: Colors.black87)),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text("Message", style: TextStyle(color: Colors.black87)),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text("Message", style: TextStyle(color: Colors.black87)),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Message", style: TextStyle(color: Colors.black87)),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Message", style: TextStyle(color: Colors.black87)),
          ],
        ),
      ),
    ];
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Signal"),
        actions: [
          IconButton(
            icon: Icon(Icons.cast_connected_outlined), onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => WebSockets()));
          },),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("${context
                    .watch<UploadProvider>()
                    .ip}"),
                Text("${context
                    .watch<UploadProvider>()
                    .isConnected}"),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 125,
            child: Stack(
              children: [
                Positioned(
                    height: 45,
                    left: 0,
                    right: 0,
                    top: 0,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 45,
                            child: RaisedButton(
                                color: Colors.blue,
                                child: Text("Refresh Ip",
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  // if (ip2.toString().isNotEmpty)
                                  SetSocket(context);
                                }),
                          ),
                        ),
                      ],
                    )),
                Positioned(
                    bottom: 60,
                    left: 0,
                    right: 0,
                    top: 45,
                    child: ListView(
                      controller: _scrollController,
                      shrinkWrap: true,
                      children: [SizedBox(height: 10), ...messageWidgets],
                    )),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SingleChildScrollView(
                        child: Row(
                      children: [
                        Expanded(
                            flex: 7,
                            child: TextFormField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Message',
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.lightBlue,
                                radius: 27,
                                child: IconButton(
                                  icon: Icon(Icons.send),
                                  onPressed: () async {
                                    var length = messageWidgets.length;
                                    var text = _messageController.text;
                                    my=text;
                                    Widget padding2 = Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: GestureDetector(
                                                onLongPress: () {
                                                  _copy(text);
                                                },
                                                onDoubleTap: () {
                                                  setState(() {
                                                    messageWidgets
                                                        .removeAt(length);
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors
                                                        .deepPurple.shade100,
                                                  ),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Text(
                                                          "${_messageController.text}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87))
                                                    ],
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    );
                                    if (_messageController.text.length > 0) {
                                      setState(() {
                                        messageWidgets.add(padding2);

                                        _scrollController.jumpTo(
                                            _scrollController
                                                .position.maxScrollExtent);
                                      });
                                      await connection?.invoke('SendMessage2',
                                          args: ['${_messageController.text}']);
                                      _messageController.text = "";
                                    }
                                  },
                                ),
                              ),
                            )),
                      ],
                    ))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  setLisIp() {
    var da = new AndroidIp().onDeviceConnected!.listen((event) async {
      var ip = event;
      var ischecked = false;
      var is8081 = false;
      var is1433 = false;
      try {
        var socket = await Socket.connect(ip, int.parse(mfav_port),
            timeout: Duration(milliseconds: 500));
        socket.close();
        context.read<UploadProvider>().ip = ip;
        ip2 = ip;
        ischecked = true;
      } catch (e) {
        // print(e);
      }
    });
  }

  Future<void> ShowFiles() async {
    setState(() {
      _showfiles.clear();
      _showfiles.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("SlNo"),
          GestureDetector(child: Text("Files")),
          Column(
            children: [
              Text("Remove"),
            ],
          ),
        ],
      ));
    });

    var path = await services.getPath();
    var files = Directory(path).listSync(recursive: true);
    int i = 0;
    files.forEach((f) {
      i++;
      setState(() {
        _showfiles.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(flex: 1, child: Text("$i")),
            Expanded(flex: 5, child: Text("${f.path.split("/").last}")),
            Expanded(
              flex: 2,
              child: IconButton(
                focusColor: Colors.deepPurpleAccent,
                hoverColor: Colors.deepPurpleAccent,
                icon: Icon(Icons.delete_forever),
                onPressed: () {
                  f.delete();
                  ShowFiles();
                },
              ),
            ),
          ],
        ));
      });
    });
  }

  Uploadf(BuildContext context) async {
    var path = await services.getPath();
    var files = Directory(path).listSync(recursive: true);
    int i = 0;
    context.read<UploadProvider>().isupload = true;

    files.forEach((f) async {
      i++;

      var isupl = await sendFile(f.path, ip2);
      if (isde) if (isupl) f.deleteSync();
      if (files.length >= i) context.read<UploadProvider>().isupload = false;
    });
    // context.read<UploadProvider>().isupload = false;
  }

  SetSocket(BuildContext context) async {
    var da = new AndroidIp().onDeviceConnected!.listen((event) async {
      var ip = event;
      var ischecked = false;
      var is8081 = false;
      var is1433 = false;
      try {
        var socket = await Socket.connect(ip, int.parse(mfav_port),
            timeout: Duration(milliseconds: 500));
        socket.close();
        context.read<UploadProvider>().ip = ip;
        ip2 = ip;
        initHub();
        ischecked = true;
      } catch (e) {
        // print(e);
      }
    });
  }

  void _copy(String clip) {
    var clipboardData = ClipboardData(text: clip);
    print("=====>" + clip);
    Clipboard.setData(clipboardData);
    key.currentState!.showSnackBar(SnackBar(content: Text("Copied")));

    // Scaffold.of(context).showBottomSheet<void>(
    //   (BuildContext context) {
    //     return Container(
    //       alignment: Alignment.center,
    //       height: 200,
    //       color: Colors.amber,
    //       child: Center(
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: <Widget>[
    //             const Text('BottomSheet'),
    //             ElevatedButton(
    //               child: const Text('Close BottomSheet'),
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //             )
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }

  void ClearFile(BuildContext context) {
    services.setRefresh();
  }
}
