import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/util/Constants.dart';

var _portController = TextEditingController(text: "8069");

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _portController.text = prefs.getString(Constants.FAVPORT) ?? "8069";
    return Scaffold(
      appBar: AppBar(
        title: Text("Share"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
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
                        child:
                            Text("Save", style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          saveTopre();
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

  void saveTopre() {
    var text = _portController.text;
    if (text.isNotEmpty) {
      prefs.setString(Constants.FAVPORT, text);
      mfav_port = text;
    }
  }
}
