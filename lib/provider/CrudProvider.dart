import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CrudProvider with ChangeNotifier, DiagnosticableTreeMixin {
  CrudProvider();

  var _isChanged = false;
  var _isChangedclear = false;

  get isChangedclear => _isChangedclear;

  set isChangedclear(value) {
    _isChangedclear = value;
    print(value);
    notifyListeners();
  }

  get isChanged => _isChanged;

  set isChanged(value) {
    print(value);

    _isChanged = value;
    notifyListeners();
    isChangedclear = value;
  }
}
