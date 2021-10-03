import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_process_text/flutter_process_text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelf_router/shelf_router.dart' as r;
import 'package:untitled1/provider/CrudProvider.dart';
import 'package:untitled1/provider/MedaProvider.dart';
import 'package:untitled1/provider/MyProvider.dart';
import 'package:untitled1/provider/RegProvider.dart';
import 'package:untitled1/provider/TutsProvider.dart' as ap;
import 'package:untitled1/provider/UploadProvider.dart';
import 'package:untitled1/repository/AppDatabase.dart';
import 'package:untitled1/repository/Notes_dao.dart';
import 'package:untitled1/repository/Tuts_dao.dart';
import 'package:untitled1/service/Service.dart';
import 'package:untitled1/ui/MyApp.dart';

import 'util/webserver.dart';

TextEditingController? textcontroller = TextEditingController();
var address = "";

var url_ = '';
var mfav_port = '8069';

late HttpServer server;
late r.Router app;
AppDatabase? database = null;
Notesdao? notesdao = null;
Tutsdao? tutsdao = null;
late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Initial();
  ShareStarter();
  // sendFile();
  FlutterProcessText.initialize(
    showConfirmationToast: true,
    showRefreshToast: true,
    showErrorToast: true,
    confirmationMessage: "Text Added",
    refreshMessage: "Got all Text",
    errorMessage: "Some Error",
  );
  FlutterProcessText.getProcessTextStream.listen((event) {
    print("================>$event");
  });

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyProvider()),
        ChangeNotifierProvider(
            create: (_) => RegProvider(database!, notesdao!)),
        ChangeNotifierProvider(
            create: (_) => ap.RegProvider(database!, tutsdao!)),
        ChangeNotifierProvider(create: (_) => MediaProvider()),
        ChangeNotifierProvider(create: (_) => CrudProvider()),
        ChangeNotifierProvider(create: (_) => UploadProvider()),
      ],
      // child: MaterialApp(home: RegRoute())));
      child: MyApp()));
  // runApp(MyApp());
}

void ShareStarter() {
  // Create the share service
  ShareService()
    // Register a callback so that we handle shared data if it arrives while the
    // app is running
    ..onDataReceived = _handleSharedData
    ..onFileReceived = _fileReceived
    // Check to see if there is any shared data already, meaning that the app
    // was launched via sharing.
    ..getSharedText().then(_handleSharedData)
    ..getSharedDatafile().then(_fileReceived);
}

void _fileReceived(List<String> p1) {
  // wid = Text(p1[0]??"null");
}

Widget wid = Text("it");
var proces_txt="";
/// Handles any shared data we may receive.
void _handleSharedData(String sharedData) {
  print("===============>"+sharedData);
  proces_txt=sharedData;
  wid = Text(sharedData);
  // print("===============123share>" + sharedData+"<===");
}

var i = true;

extension Digitalsize on int {
  String get toDigital => this < 100000
      ? "${(.001 * this).roundToDouble()}" + "kB"
      : "${(.000001 * this).roundToDouble()}" + "MB";
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// void main(){
//   runApp(MaterialApp(home:Text("hdfdf")));
// }
