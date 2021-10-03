import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/src/provider.dart';
import 'package:untitled1/provider/MedaProvider.dart';

class FindDialog extends StatelessWidget {
  Function(Map<int, String> text) okCallback;

  var title;

  int type;

  FindDialog({Key? key, required this.okCallback, this.title, this.type = 1})
      : super(key: key);

  void clearController(TextEditingController controller) {
    controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    if (type == 2)
      return IpWidget(context);
    else if (type == 3)
      return Searching(context);
    else
      return Basic(context);

    var onPressed2 = () {};
  }

  var outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black87, width: 1.5));
  var outlineInputBorder2 = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.indigoAccent, width: 2),
  );

  Widget IpWidget(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black87, width: 1.5));
    return AlertDialog(
      title: Center(child: Text("$title")),
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.only(top: 14.0, bottom: 4),
      content: Container(
        height: 105,
        child: Theme(
          data: new ThemeData(
            hintColor: Colors.black54,
          ),
          child: Column(
            children: [
              Container(
                height: 45,
                child: TextFormField(

                  keyboardType: TextInputType.number,
                  controller: port_controller,
                  decoration: InputDecoration(
                    focusedBorder: outlineInputBorder2,
                    suffixIcon: context.watch<MediaProvider>().isChangeDialog_Ip
                        ? IconButton(
                            onPressed: () {
                              clearController(port_controller);
                            },
                            icon: Icon(Icons.clear))
                        : null,
                    // errorBorder: outlineInputBorder,
                    // focusedErrorBorder: outlineInputBorder,
                    // focusedBorder: outlineInputBorder,
                    // disabledBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.deepPurpleAccent, width: 2)),
                    hintText: 'IP',
                  ),
                  onChanged: (val) {
                    if (val.isNotEmpty) {
                      context
                          .read<MediaProvider>()
                          .isChangeDialog_Ip = true;
                      context
                          .read<MediaProvider>()
                          .isChangeDialog = true;
                    } else {
                      context
                          .read<MediaProvider>()
                          .isChangeDialog = false;
                      context
                          .read<MediaProvider>()
                          .isChangeDialog_Ip = false;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                height: 45,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: find_controller,
                  decoration: InputDecoration(
                    focusedBorder: outlineInputBorder2,
                    enabledBorder: outlineInputBorder,
                    // disabledBorder: OutlineInputBorder(
                    //
                    //     borderSide: BorderSide(color: Colors.redAccent),borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    suffixIcon:
                        context.watch<MediaProvider>().isChangeDialog_port
                            ? IconButton(
                        onPressed: () {
                          clearController(find_controller);
                        },
                        icon: Icon(Icons.clear))
                        : null,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.deepPurpleAccent, width: 2)),
                    hintText: 'Port',
                  ),
                  onChanged: (val) {
                    if (val.isNotEmpty) {
                      context
                          .read<MediaProvider>()
                          .isChangeDialog_port = true;
                      context
                          .read<MediaProvider>()
                          .isChangeDialog = true;
                    } else {
                      context
                          .read<MediaProvider>()
                          .isChangeDialog = false;
                      context
                          .read<MediaProvider>()
                          .isChangeDialog_port = false;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: OutlinedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Icon(Icons.clear),
                        ),
                      ),
                      Text("Cancel")
                    ],
                  ),
                  onPressed: () {
                    context
                        .read<MediaProvider>()
                        .isChangeDialog = false;
                    Navigator.of(context).pop();
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                  onPressed: context
                      .watch<MediaProvider>()
                      .isChangeDialog
                      ? () {
                          context.read<MediaProvider>().isChangeDialog = false;
                          okCallback({
                            1: port_controller.text,
                            2: find_controller.text
                          });
                          Navigator.of(context).pop();
                        }
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Icon(Icons.check),
                        ),
                      ),
                      Text("OK")
                    ],
                  )),
            )
          ],
        ),
      ],
    );
  }

  Widget Basic(BuildContext context) {

    return AlertDialog(
      title: Center(child: Text("$title")),
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.only(top: 14.0, bottom: 4),
      content: Container(
        height: 50,
        child: TextFormField(
          controller: find_controller,
          decoration: InputDecoration(
            focusedBorder: outlineInputBorder2,
            enabledBorder: outlineInputBorder,
            suffixIcon: context
                .watch<MediaProvider>()
                .isChangeDialog
                ? IconButton(
                onPressed: () {
                  clearController(find_controller);
                },
                icon: Icon(Icons.clear))
                : null,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple)),
            hintText: 'Info',
          ),
          onChanged: (val) {
            if (val.isNotEmpty)
              context.read<MediaProvider>().isChangeDialog = true;
            else
              context.read<MediaProvider>().isChangeDialog = false;
          },
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: OutlinedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Icon(Icons.clear),
                        ),
                      ),
                      Text("Cancel")
                    ],
                  ),
                  onPressed: () {
                    context.read<MediaProvider>().isChangeDialog = false;
                    Navigator.of(context).pop();
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                  onPressed: context.watch<MediaProvider>().isChangeDialog
                      ? () {
                    context
                        .read<MediaProvider>()
                        .isChangeDialog = false;
                    okCallback({
                      1: find_controller.text,
                      2: port_controller.text
                    });
                    Navigator.of(context).pop();
                  }
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Icon(Icons.check),
                        ),
                      ),
                      Text("OK")
                    ],
                  )),
            )
          ],
        ),
      ],
    );
  }

  Widget Searching(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text("$title")),
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.only(top: 14.0, bottom: 4),
      content: Container(
        height: 50,
        child: Lottie.asset('assets/files/radar.json'),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: OutlinedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Icon(Icons.clear),
                        ),
                      ),
                      Text("Cancel")
                    ],
                  ),
                  onPressed: () {
                    context.read<MediaProvider>().isChangeDialog = false;
                    Navigator.of(context).pop();
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                  onPressed: context.watch<MediaProvider>().isChangeDialog
                      ? () {
                          context.read<MediaProvider>().isChangeDialog = false;
                          okCallback({
                            1: find_controller.text,
                            2: port_controller.text
                          });
                          Navigator.of(context).pop();
                        }
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Icon(Icons.check),
                        ),
                      ),
                      Text("OK")
                    ],
                  )),
            )
          ],
        ),
      ],
    );
  }
}

var find_controller = TextEditingController();
var port_controller = TextEditingController();
// Create AlertDialog
