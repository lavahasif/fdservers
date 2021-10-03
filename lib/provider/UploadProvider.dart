import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class UploadProvider with ChangeNotifier, DiagnosticableTreeMixin {
  var _isConnected="";

  get isConnected => _isConnected;

  set isConnected(value) {
    _isConnected = value;
    notifyListeners();
  }

  UploadProvider();

  var _isupload = false;

  get isupload => _isupload;

  set isupload(value) {
    _isupload = value;
    notifyListeners();
  }

  var _ip = "";

  get ip => _ip;

  set ip(value) {
    _ip = value;
    notifyListeners();
  }

  bool _isde = false;

  bool get isde => _isde;

  set isde(bool value) {
    _isde = value;
    // notifyListeners();
  }
}
