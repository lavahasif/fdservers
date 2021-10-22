import 'package:flutter/foundation.dart';

class WhatsAppprovider with ChangeNotifier, DiagnosticableTreeMixin {
  List<String> _numberlist = [];

  List<String> get numberlist => _numberlist;

  set numberlist(List<String> value) {
    _numberlist = value;
    notifyListeners();
  }

  var _whatsappmessage = "";

  get whatsappmessage => _whatsappmessage;

  set whatsappmessage(value) {
    _whatsappmessage = value;
    notifyListeners();
  }

   whatsappmessage_up(value) {
    _whatsappmessage = value;

  }
}
