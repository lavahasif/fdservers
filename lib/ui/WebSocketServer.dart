import 'dart:io';
import 'dart:typed_data';

import 'package:android_util/android_ip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/src/provider.dart';
import 'package:untitled1/provider/UploadProvider.dart';
import 'package:untitled1/service/Service.dart';

import '../main.dart';

class WebSocketServer extends StatefulWidget {
  var bools;

  var ip;

  var port;

  WebSocketServer(this.ip, this.port, this.bools, {Key? key}) : super(key: key);

  @override
  State<WebSocketServer> createState() => _WebSocketServerState();
}

var key = GlobalKey<ScaffoldState>();
var messageWidgets = [];
var _ipController = TextEditingController();
var _messageController = TextEditingController();
var _portController = TextEditingController(text: "4567");
var _scrollController = ScrollController();
var _showfiles = [];

class _WebSocketServerState extends State<WebSocketServer> {
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
    startserver();
  }

  var my = "";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    servers?.close();
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
                            child: RaisedButton(
                                color: Colors.blue,
                                child: Text("Refresh Ip",
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
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
                                      // if (widget.bools) {
                                      //   servers?.forEach((element) {
                                      //
                                      //   });
                                      // }
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
        var socket = await Socket.connect(ip, 8069,
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
    print("=====>" + clip);
    Clipboard.setData(clipboardData);
    key.currentState!.showSnackBar(SnackBar(content: Text("Copied")));
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

  void handleConnection(Socket client) {
    print('Connection from'
        ' ${client.remoteAddress.address}:${client.remotePort}');

    // listen for events from the client
    client.listen(
      // handle data from the client
      (Uint8List data) async {
        await Future.delayed(Duration(seconds: 1));
        final message = String.fromCharCodes(data);
        int length = messageWidgets.length;
        Widget padding2 = Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                    onLongPress: () {
                      _copy(message);
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
                        color: Color(0xDD44871F),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Column(
                            // direction: Axis.vertical,
                            children: [
                              Text("${client.remoteAddress.host}::-",
                                  style: TextStyle(color: Colors.black87)),
                              Text("${message}",
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
        print(error);
        setMwidget(error);
        client.close();
      },

      // handle the client closing the connection
      onDone: () {
        print('Client left');
        client.close();
      },
    );
  }

  ServerSocket? servers = null;
  Socket? socket = null;

  Future<void> startserver() async {
    var anyIPv4 = InternetAddress.anyIPv4;
    print(anyIPv4.address);
    servers = await ServerSocket.bind(anyIPv4, int.parse(widget.port));
    // server.forEach((element) {});
    // listen for clent connections to the server
    servers?.listen((client) {
      socket = client;
      setMwidget("${socket?.address.host.toString()}  Connected");
      handleConnection(client);
    });
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
    await Future.delayed(Duration(seconds: 2));
  }
}
