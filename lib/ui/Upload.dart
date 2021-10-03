import 'dart:io';

import 'package:android_util/android_ip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/provider/UploadProvider.dart';
import 'package:untitled1/service/Service.dart';
import 'package:untitled1/util/webserver.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

var _ondeviceconnected2 = [];
var _showfiles = [];

class _UploadState extends State<Upload> {
  ShareService services = ShareService();
  var ip2 = "";
  var isde = false;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    SetSocket();
  }

  @override
  Widget build(BuildContext context) {
    isde = context.watch<UploadProvider>().isde;
    // setLisIp();
    // ip2 = context.watch<UploadProvider>().ip;
    // if (ip2.toString().isNotEmpty) Uploadf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Share"),
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
        child: ListView(
          // shrinkWrap: true,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(ip2),
                ),
                Expanded(
                  flex: 1,
                  child: Text(proces_txt),
                ),
              ],
            ),
            ..._ondeviceconnected2,
            ..._showfiles,
            context.read<UploadProvider>().isupload
                ? Align(
                    child: CircularProgressIndicator(),
                  )
                : Container(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 63,
                    child: RaisedButton(
                        color: Colors.blue,
                        child: Text("Show Device",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () => setLisIp()),
                  ),
                ),
                SizedBox(width: 25),
                Expanded(
                  child: Container(
                    height: 63,
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text("Show Files",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        ShowFiles();
                      },
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 63,
                    child: RaisedButton(
                        color: Colors.blue,
                        child: Text("Upload",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          if (ip2.toString().isNotEmpty) Uploadf(context);
                        }),
                  ),
                ),
                SizedBox(width: 25),
                Expanded(
                  child: Container(
                    height: 63,
                    child: RaisedButton(
                      color: Colors.blue,
                      child:
                          Text("Clear", style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        ClearFile(context);
                      },
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 63,
                    child: RaisedButton(
                        color: Colors.blue,
                        child: Text("Message",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          if (proces_txt.toString().isNotEmpty &&
                              ip2.toString().isNotEmpty) Uploadtext(context);
                        }),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  setLisIp() {
    setState(() {
      _ondeviceconnected2.clear();
      _ondeviceconnected2.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("SlNo"),
          GestureDetector(child: Text("Devices")),
          Column(
            children: [
              Text("$mfav_port"),
            ],
          ),
        ],
      ));
    });
    var count = 0;

    var da = new AndroidIp().onDeviceConnected!.listen((event) async {
      var ip = event;
      var ischecked = false;
      var is8081 = false;
      var is1433 = false;
      if (ip != "127.0.0.1" || ip != "localhost") {
        try {
          var socket = await Socket.connect(ip, int.parse(mfav_port),
              timeout: Duration(milliseconds: 500));
          socket.close();
          context.read<UploadProvider>().ip = ip;
          ip2 = ip;
          ischecked = true;
        } catch (e) {
          print(e);
        }

        setState(() {
          count++;
          _ondeviceconnected2.add(GestureDetector(
            onTap: () {
              context.read<UploadProvider>().ip = ip;
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("$count"),
                Text("$ip"),
                Column(
                  children: [
                    // Text("$mfav_port"),
                    Checkbox(value: ischecked, onChanged: (_) {}),
                  ],
                ),
              ],
            ),
          ));
        });
      }
    });
  }

  SetSocket() async {
    var da = new AndroidIp().onDeviceConnected!.listen((event) async {
      var ip = event;

      if (ip != "127.0.0.1" || ip != "localhost") {
        try {
          var socket = await Socket.connect(ip, int.parse(mfav_port),
              timeout: Duration(milliseconds: 500));
          socket.close();
          context.read<UploadProvider>().ip = ip;
          context.read<UploadProvider>().isConnected = "Connected";
          ip2 = ip;
        } catch (e) {
          // print(e);
        }
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

  Uploadtext(BuildContext context) async {
    var isupl = await sendText(proces_txt, ip2);
    if (isupl) setState(() {
      proces_txt = "";
    });
    // context.read<UploadProvider>().isupload = false;
  }

  void ClearFile(BuildContext context) {
    services.setRefresh();
  }
}
