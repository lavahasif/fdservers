import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class MyProvider with ChangeNotifier, DiagnosticableTreeMixin {
  var _iptext = "";

  // TextEditingController textcontroller;

  MyProvider();

  get iptext => _iptext;
  var _loading = false;

  get loading => _loading;

  set loading(value) {
    _loading = value;
    print("------------->$value");
    notifyListeners();
  }

  set iptext(value) {
    print("---------------------->" + value);
    _iptext = value;
    // textcontroller.text = value;
    // print("---------------------->"+textcontroller.text);
    notifyListeners();
  }

  void launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url_';
}
