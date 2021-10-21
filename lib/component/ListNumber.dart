import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:untitled1/provider/WhatsAppprovider.dart';
import 'package:untitled1/service/Service.dart';
import 'package:untitled1/util/Constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ListNumber extends StatelessWidget {
  List<TextEditingController> _portController = [];

  ListNumber({Key? key}) : super(key: key);
  var shareService = ShareService();

  @override
  Widget build(BuildContext context) {
    List<String> numberlist2 = context.watch<WhatsAppprovider>().numberlist;
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
                child: RaisedButton(
                    color: Colors.blue,
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
          height: 500,
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
                                    icon: Icon(Icons.business,color: Colors.green),
                                    onPressed: () => open(context,
                                        _portController[index].text, "B")),
                                IconButton(
                                    icon: FaIcon(FontAwesomeIcons.whatsapp,
                                        color: Colors.green),
                                    onPressed: () => open(context,
                                        _portController[index].text, "C")),
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

  Future<void> open(BuildContext context, text, type) async {
    // _portController.text = "919747200785";

    if (text.isNotEmpty) {
      print(Constants.Sdk);
      print(Constants.Sdk);

      if (Constants.Sdk >= 29)
        shareService.openWhats(text, "hi", type);
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
