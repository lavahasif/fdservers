import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/component/ListNumber.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/provider/WhatsAppprovider.dart';
import 'package:untitled1/service/Service.dart';
import 'package:untitled1/util/Constants.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppopen extends StatelessWidget {
  WhatsAppopen({Key? key}) : super(key: key);
  var _portController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    _portController.text = proces_txt;
    var scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            height: 48,
            width: 48,
            child: IconButton(
              icon: Icon(
                Icons.upgrade,
                size: 30,
              ),
              color: Colors.white,
              onPressed: () {
                scrollController.jumpTo(0);
              },
            ),
          ),
          Container(
            height: 48,
            width: 48,
            child: IconButton(
              icon: Icon(
                Icons.vertical_align_bottom,
                size: 30,
              ),
              color: Colors.white,
              onPressed: () {
                scrollController.jumpTo(500);
              },
            ),
          ),
          Container(
            height: 48,
            width: 48,
            child: IconButton(
              icon: Icon(
                Icons.clear,
                size: 30,
              ),
              color: Colors.white,
              onPressed: () {
                Provider.of<WhatsAppprovider>(context, listen: false)
                    .numberlist = [];
              },
            ),
          ),
        ],
        title: Text("Open WhatsApp"),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        physics: ScrollPhysics(),
        child: Padding(
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
                            prefixIcon: IconButton(
                                icon: Icon(Icons.nine_k),
                                onPressed: () => _portController.text =
                                    "91" + _portController.text),
                            suffixIcon: Wrap(
                              children: [
                                IconButton(
                                    icon: Icon(Icons.paste),
                                    onPressed: () => _copy()),
                                IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () => _portController.clear()),
                              ],
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
                          child: Text("Buisness",
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            open(context, "B");
                          }),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      height: 63,
                      child: RaisedButton(
                          color: Colors.blue,
                          child: Text("Open Whatsapp",
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            open(context, "C");
                          }),
                    ),
                  ),
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
                          child: Text("Open All",
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            open(context, "A");
                          }),
                    ),
                  ),
                ],
              ),
              // Container(
              //     height: 300.0,
              //     child:
              SingleChildScrollView(child: ListNumber())
              // )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> open(BuildContext context, type) async {
    // _portController.text = "919747200785";
    var text = _portController.text;

    if (text.isNotEmpty) {
      print(Constants.Sdk);
      print(Constants.Sdk);
      if (Constants.Sdk >= 29)
        ShareService().openWhats(text, "hi", type);
      else {
        // var component2 =
        //     "whatsapp://917012438494?text=The text message goes here";
        var component2 = "https://wa.me/${text.replaceAll("+", "")}/?text=hi";
        // var component2 = "https://api.whatsapp.com/send?phone="+ text.replaceAll("+", "") +"&text=" + Uri.encodeComponent("mensaje");;
        // var url = Uri.encodeComponent(component);
        var bool = await canLaunch(component2);
        bool ? await launch(component2) : throw 'Could not launch $component2';
      }
    }
  }

  Future<void> _copy() async {
    final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null) {
      var cp = data.text?.replaceAll("+", '').replaceAll('|', '');
      ;
      if (cp!.substring(0, 1) == "0")
        _portController.text = cp.substring(1);
      else
        _portController.text = cp;
    }
  }
}
