import 'package:flutter/foundation.dart';

class WhatsAppprovider with ChangeNotifier, DiagnosticableTreeMixin {
  List<String> _numberlist = [];

  List<String> get numberlist => _numberlist;

  set numberlist(List<String> value) {
    _numberlist = value;
    notifyListeners();
  }
}
