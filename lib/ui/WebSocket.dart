import 'dart:io';

import 'package:android_util/android_ip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/src/provider.dart';
import 'package:untitled1/provider/UploadProvider.dart';
import 'package:untitled1/service/Service.dart';
import 'package:untitled1/ui/WebSocketClient.dart';

import '../main.dart';
import 'WebSocketServer.dart';

class WebSockets extends StatefulWidget {
  const WebSockets({Key? key}) : super(key: key);

  @override
  State<WebSockets> createState() => _WebSocketsState();
}

var key = GlobalKey<ScaffoldState>();
var messageWidgets = [];
var _ipController = TextEditingController();
var _portController = TextEditingController(text: "121");
var _scrollController = ScrollController();
var _showfiles = [];

class _WebSocketsState extends State<WebSockets> {
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

  void initHub() {}
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
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 7,
                        child: TextFormField(
                          controller: _ipController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'IP',
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: IconButton(
                          icon: Wrap(
                            direction: Axis.vertical,
                            children: [Icon(Icons.settings), Text("Ser")],
                          ),
                          onPressed: () {
                            setIp();
                          },
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 7,
                        child: TextFormField(
                          controller: _portController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Port',
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: IconButton(
                          icon: Wrap(
                            direction: Axis.vertical,
                            children: [Icon(Icons.call_received), Text("Rec")],
                          ),
                          onPressed: () {
                            SetSocket();
                          },
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 63,
                        child: RaisedButton(
                            color: Colors.blue,
                            child: Text("Save",
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              saveTopre();
                            }),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 63,
                        child: RaisedButton(
                            color: Colors.blue,
                            child: Text("Server",
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WebSocketServer(
                                          _ipController.text,
                                          _portController.text,
                                          true)));
                            }),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 63,
                        child: RaisedButton(
                            color: Colors.blue,
                            child: Text("Receiver",
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WebSocketClient(
                                          _ipController.text,
                                          _portController.text,
                                          false)));
                            }),
                      ),
                    ),
                  ],
                ),
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

  SetSocket() async {
    var da = new AndroidIp().onDeviceConnected!.listen((event) async {
      var ip = event;
      var ischecked = false;
      var is8081 = false;
      var is1433 = false;
      try {
        var socket = await Socket.connect(ip, int.parse(port),
            timeout: Duration(milliseconds: 500));
        socket.close();
        context.read<UploadProvider>().ip = ip;
        ip2 = ip;
        setState(() {
          _ipController.text = ip;
          _portController.text = port;
        });
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
}
