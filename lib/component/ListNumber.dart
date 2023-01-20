import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';

import 'package:url_launcher/url_launcher.dart';

import '../provider/WhatsAppprovider.dart';
import '../service/Service.dart';
import '../util/Constants.dart';

class ListNumber extends StatelessWidget {
  List<TextEditingController> _portController = [];

  ListNumber({Key? key}) : super(key: key);
  var shareService = ShareService();

  @override
  Widget build(BuildContext context) {
    List<String> numberlist2 = context
        .watch<WhatsAppprovider>()
        .numberlist;
    var whatsappmessage = context
        .watch<WhatsAppprovider>()
        .whatsappmessage;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 63,
                child:  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary:Colors.blue),
                    child: Text("Pick File",
                        style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();

                      if (result != null) {
                        var path2 = result.files.single.path;
                        File file = File(path2!);
                        var readAsString = await file.readAsString();
                        List<String> split = readAsString.split(',');
                        print(split);
                        List<String> number = [];
                        split.forEach((element) {
                          if (element.length > 3) number.add(element.trim());
                        });
                        Provider.of<WhatsAppprovider>(context, listen: false)
                            .numberlist = number;
                      } else {
                        // User canceled the picker
                      }
                    }),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          padding: EdgeInsets.only(top: 75),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: numberlist2.length,
              itemBuilder: (BuildContext context, int index) {
                _portController
                    .add(TextEditingController(text: numberlist2[index]));
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _portController[index],
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'mob',
                            prefixIcon: IconButton(
                                icon: Column(
                                  children: [
                                    Icon(Icons.nine_k,color: Colors.lightBlue,),
                                    Text(
                                      (index + 1).toString(),
                                      style: TextStyle(fontSize: 6),
                                    ),
                                  ],
                                ),
                                onPressed: () => _portController[index].text =
                                    "91" + _portController[index].text),
                            suffixIcon: Wrap(
                              children: [
                                IconButton(
                                    icon: Icon(
                                        Icons.business, color: Colors.green),
                                    onPressed: () =>
                                        open(context,
                                            _portController[index].text, "B",
                                            whatsappmessage)),
                                IconButton(
                                    icon: FaIcon(FontAwesomeIcons.whatsapp,
                                        color: Colors.green),
                                    onPressed: () =>
                                        open(context,
                                            _portController[index].text, "C",
                                            whatsappmessage)),
                                IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.redAccent,
                                    ),
                                    onPressed: () =>
                                        _portController[index].clear()),
                              ],
                            )),
                      )),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }

  Future<void> open(BuildContext context, text, type, String messages) async {
    // _portController.text = "919747200785";

    if (text.isNotEmpty) {
      print(Constants.Sdk);
      print(Constants.Sdk);

      var message = messages;
      if (Constants.Sdk >= 19 && Constants.Sdk <= 28) {
        print(type);
        if (type == 'A') {
          print(type);
          // var component2 =
          //     "whatsapp://917012438494?text=The text message goes here";
          var component2 = "https://wa.me/${text.replaceAll("+", "")}/?text=hi";
          print(component2);
          // var component2 = "https://api.whatsapp.com/send?phone="+ text.replaceAll("+", "") +"&text=" + Uri.encodeComponent("mensaje");;
          // var url = Uri.encodeComponent(component);
          var bool = await canLaunch(component2);
          bool
              ? await launch(component2)
              : throw 'Could not launch $component2';
        } else {
          ShareService().openWhats(text, message, type);
        }
      } else if (Constants.Sdk >= 29)
        ShareService().openWhats(text, message, type);
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
}
