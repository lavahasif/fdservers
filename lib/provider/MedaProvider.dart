import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class MediaProvider with ChangeNotifier, DiagnosticableTreeMixin {
  MediaProvider();

  double _height = 0;

  double get height => _height;
  double _width = 0;

  set height(double value) {
    _height = value;
    // notifyListeners();
  }

  double get width => _width;

  set width(double value) {
    _width = value;
    // notifyListeners();
  }

  get isChangeDialog => _isChangeDialog;

  set isChangeDialog(value) {
    _isChangeDialog = value;
    notifyListeners();
  }

  get isChangeDialog_Ip => _isChangeDialog_Ip;

  set isChangeDialog_Ip(value) {
    _isChangeDialog_Ip = value;
    notifyListeners();
  }

  var _isChangeDialog=false;
  var _isChangeDialog_port=false;
  var _isChangeDialog_Ip=false;

  get isChangeDialog_port => _isChangeDialog_port;

  set isChangeDialog_port(value) {
    _isChangeDialog_port = value;
    notifyListeners();
  }
}
