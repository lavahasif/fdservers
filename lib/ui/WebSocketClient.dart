import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:android_util/android_ip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/src/provider.dart';

import '../main.dart';
import '../provider/UploadProvider.dart';
import '../service/Service.dart';

class WebSocketClient extends StatefulWidget {
  var bools;

  var ip;

  var port;

  WebSocketClient(this.ip, this.port, this.bools, {Key? key}) : super(key: key);

  @override
  State<WebSocketClient> createState() => _WebSocketClientState();
}

var key = GlobalKey<ScaffoldState>();
var messageWidgets = [];
var _ipController = TextEditingController();
var _messageController = TextEditingController();
var _portController = TextEditingController(text: "4567");
var _scrollController = ScrollController();
var _showfiles = [];

class _WebSocketClientState extends State<WebSocketClient> {
  ShareService services = ShareService();
  var ip2 = "";
  var isde = false;

  @override
  initState() {
    super.initState();
    initTopre();
    initHub();

    if (proces_txt.length > 0) _ipController.text = proces_txt;
  }

  var retry = 0;

  void initHub() {
    startclient();
  }

  var my = "";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isde = context.watch<UploadProvider>().isde;
    // setLisIp();
    // ip2 = context.watch<UploadProvider>().ip;
    // if (ip2.toString().isNotEmpty) Uploadf(context);

    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Chat"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("${context.watch<UploadProvider>().ip}"),
                Text("${context.watch<UploadProvider>().isConnected}"),
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
                            child:  ElevatedButton(
                                style: ElevatedButton.styleFrom(primary:Colors.blue),
                                child: Text("Refresh Ip",
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  // if (ip2.toString().isNotEmpty)
                                  initHub();
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
                                        my = text;
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

                                          sendMessage(
                                              socket!, _messageController.text);
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

  void _copy(String clip) {
    var clipboardData = ClipboardData(text: clip);
    print("=====>" + clip)
;    Clipboard.setData(clipboardData);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Copied")));
    // key.currentState!.showSnackBar(SnackBar(content: Text("Copied")));
  }

  Future<void> setIp() async {
    var ip = await AndroidIp.IpAddress_Wifi_tetherorwifi;
    setState(() {
      _ipController.text = (ip == "Null" ? "localhost" : ip)!;
    });
  }

  void saveTopre() {
    prefs.setString("ip", _ipController.text);
    prefs.setString("port", _portController.text);
    port = prefs.getString("port") ?? "4567";
  }

  var port = "4567";

  void initTopre() {
    _ipController.text = prefs.getString("ip") ?? "localhost";
    _portController.text = prefs.getString("port") ?? "4567";
    port = prefs.getString("port") ?? "4567";
  }

  Socket? socket = null;

  Future<void> startclient() async {
    // connect to the socket server
    // int.parse(widget.port)
    socket = await Socket.connect(widget.ip, int.parse(widget.port));
    print(
        'Connected to: ${socket?.remoteAddress.address}:${socket?.remotePort}');
    setMwidget("${socket?.address.host.toString()}  Connected");
    // listen for responses from the server
    socket?.listen(
      // handle data from the server
          (Uint8List data) {
        final serverResponse = utf8.decode(data);
        // final serverResponse = String.fromCharCodes(data);
        print('Server: $serverResponse');

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
                      _copy(serverResponse);
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
                          Column(
                            // direction: Axis.vertical,
                            children: [
                              Text("${socket?.address.host}::-",
                                  style: TextStyle(color: Colors.black87)),
                              Text("${serverResponse}",
                                  style: TextStyle(color: Colors.black87)),
                            ],
                          )
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
      },

      // handle errors
      onError: (error) {
        print("==>" + error);

        setMwidget(error);
        socket?.destroy();
      },

      // handle server ending connection
      onDone: () {
        print('Server left.');
        socket?.destroy();
      },
    );

    // // send some messages to the server
    // await sendMessage(socket, 'Knock, knock.');
    // await sendMessage(socket, 'Banana');
    // await sendMessage(socket, 'Banana');
    // await sendMessage(socket, 'Banana');
    // await sendMessage(socket, 'Banana');
    // await sendMessage(socket, 'Banana');
    // await sendMessage(socket, 'Orange');
    // await sendMessage(socket, "Orange you glad I didn't say banana again?");
  }

  void setMwidget(error) {
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
                  _copy(error);
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
                    color: Color(0xDDE80E3D),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        // direction: Axis.vertical,
                        children: [
                          Text("${socket?.address.host}::-",
                              style: TextStyle(color: Colors.black87)),
                          Text("${error}",
                              style: TextStyle(color: Colors.black87)),
                        ],
                      )
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
  }

  Future<void> sendMessage(Socket socket, String message) async {
    print('Client: $message');
    socket.write(message);
    // await Future.delayed(Duration(seconds: 2));
  }
}
