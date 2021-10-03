import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:untitled1/provider/CrudProvider.dart';

typedef CrudCallback = Function(BuildContext);

class CrudAction extends StatelessWidget {
  var clearCallback;
  var saveCallback;

  var findCallback;

  var deleteCallback;

  var editCallback;

  CrudAction(
      {Key? key,
      this.saveCallback,
      required this.clearCallback,
      this.findCallback,
      this.deleteCallback,
      this.editCallback})
      : super(key: key);

  BorderSide? getcolor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.disabled,
    };
    if (states.any(interactiveStates.contains)) {
      return BorderSide(
          color: Colors.black54, width: 1.0, style: BorderStyle.solid);
    } else {
      return BorderSide(
          color: Colors.blueAccent, width: 1.0, style: BorderStyle.solid);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ButtonStyle(
    //     side: MaterialStateProperty.all(BorderSide(
    //         color: Colors.blue, width: 1.0, style: BorderStyle.solid)));
    var buttonStyle2 =
        ButtonStyle(side: MaterialStateProperty.resolveWith(getcolor));
    var buttonStyle = buttonStyle2;

    MaterialPropertyResolver<BorderSide?> _getcolor =
        (Set<MaterialState> states) {};

    return ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: OutlinedButton(
              style: buttonStyle,
              onPressed: context.watch<CrudProvider>().isChanged
                  ? () => saveCallback(context)
                  : null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(
                        Icons.save,
                        size: 24,
                      ),
                    ),
                  ),
                  Text("Save")
                ],
              )),
        ),
        // Consumer(builder: (_, b, _) {
        //
        //
        // }),
        context.watch<CrudProvider>().isChangedclear
            ? Padding(
                padding: const EdgeInsets.all(4.0),
                child: OutlinedButton(
                    style: buttonStyle,
                    onPressed: () => clearCallback(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Icon(
                              Icons.clear,
                              size: 24,
                            ),
                          ),
                        ),
                        Text("Clear")
                      ],
                    )),
              )
            : Padding(
                padding: const EdgeInsets.all(4.0),
                child: OutlinedButton(
                    style: buttonStyle,
                    onPressed: null,
                    child: Column(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.clear)),
                        Text("Clear")
                      ],
                    )),
              ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: OutlinedButton(
              style: buttonStyle,
              onPressed: () => findCallback(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(Icons.find_in_page_outlined),
                    ),
                  ),
                  Text("Find")
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: OutlinedButton(
              style: buttonStyle,
              onPressed: () => deleteCallback(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(Icons.delete),
                    ),
                  ),
                  Text("Delete")
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: OutlinedButton(
              style: buttonStyle,
              onPressed: context.watch<CrudProvider>().isChanged
                  ? () => editCallback(context)
                  : null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(Icons.edit),
                    ),
                  ),
                  Text("Edit")
                ],
              )),
        )
      ],
    );
  }
}
