import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/util/Constants.dart';

var _portController = TextEditingController(text: "8069");
var _ipController = TextEditingController(text: "192.168.43.84");
var _timeoutController = TextEditingController(text: "5000");
var _timeout2Controller = TextEditingController(text: "5000");
GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _portController.text = prefs.getString(Constants.FAVPORT) ?? "8069";

    _ipController.text =
        prefs.getString(Constants.FAVPORT_IP) ?? "192.168.43.84";
    _timeoutController.text =
        prefs.getString(Constants.FAVPORT_TIMEOUT) ?? "5000";
    _timeout2Controller.text =
        prefs.getString(Constants.FAVPORT2_TIMEOUT) ?? "5000";
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
                flex: 7,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _ipController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ip',
                  ),
                )),
            Expanded(
                flex: 7,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _portController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Port',
                  ),
                )),
            Expanded(
                flex: 7,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _timeoutController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Timeout',
                  ),
                )),
            Expanded(
                flex: 7,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _timeout2Controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Timeout2',
                  ),
                )),
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
                        child:
                        Text("Save", style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          saveTopre(context);
                        }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void saveTopre(BuildContext context) {
    var port = _portController.text;
    var ip = _ipController.text;
    var timeout = _timeoutController.text;
    var timeout2 = _timeout2Controller.text;
    if (port.isNotEmpty &&
        ip.isNotEmpty &&
        timeout.isNotEmpty &&
        timeout.isNotEmpty) {
      prefs.setString(Constants.FAVPORT, port);
      prefs.setString(Constants.FAVPORT_IP, ip);
      prefs.setString(Constants.FAVPORT_TIMEOUT, timeout);
      prefs.setString(Constants.FAVPORT2_TIMEOUT, timeout2);
      mfav_port = port;
      mfav_ip = ip;
      mfav_timeout = timeout;
      mfav2_timeout = timeout2;
      key.currentState!.showSnackBar(SnackBar(content: Text("Saved")));
    }
  }
}
