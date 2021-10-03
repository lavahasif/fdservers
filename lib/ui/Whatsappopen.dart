import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/main.dart';
import 'package:url_launcher/url_launcher.dart';

var _portController = TextEditingController(text: "");

class WhatsAppopen extends StatelessWidget {
  const WhatsAppopen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _portController.text = proces_txt;
    return Scaffold(
      appBar: AppBar(
        title: Text("Open WhatsApp"),
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
                          hintText: 'mob',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              _portController.text = "";
                            },
                          )),
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
                        child: Text("Open Whatsapp",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          open(context);
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

  Future<void> open(BuildContext context) async {
    var text = _portController.text;

    if (text.isNotEmpty) {
      var url = "https://wa.me/${text.replaceAll("+", "")}/?text='hi'";
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url_';
    }
  }
}
