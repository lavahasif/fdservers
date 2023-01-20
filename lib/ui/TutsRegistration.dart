import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

// import 'package:untitled1/component/CrudButton.dart';
// import 'package:untitled1/component/FindDialog.dart';
// import 'package:untitled1/provider/CrudProvider.dart';
// import 'package:untitled1/provider/MedaProvider.dart';
// import 'package:untitled1/provider/TutsProvider.dart' as t;
// import 'package:untitled1/repository/Tuts.dart' ;
// import 'package:untitled1/util/webserver.dart';
// import 'package:untitled1/validator/validator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../component/CrudButton.dart';
import '../component/FindDialog.dart';
import '../main.dart';
import '../provider/CrudProvider.dart';
import '../provider/MedaProvider.dart';
import '../provider/TutsProvider.dart' as t;
import '../repository/Tuts.dart';
import '../util/webserver.dart';
import '../validator/validator.dart';

// GlobalKey<FormState>? formKey;

class RegRoute extends StatelessWidget {
  const RegRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    // context.read<MediaProvider>().height = size.height;
    // context.read<MediaProvider>().width = size.width;
    context.read<t.RegProvider>().getMaxCount().then((value) =>
        {print("page$value"), context.read<t.RegProvider>().maxcount = value!});

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: SingleChildScrollView(
        child: NoteRegistration(),
      ),
    );
  }
}

class NoteRegistration extends StatefulWidget {
  NoteRegistration({Key? key}) : super(key: key);

  @override
  State<NoteRegistration> createState() => _NoteRegistrationState();
}

class _NoteRegistrationState extends State<NoteRegistration> {
  var controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    link_controller.text = proces_txt;
    if (proces_txt.isNotEmpty && link_controller.text.isNotEmpty) {
      print("=======>true123");
      context.read<CrudProvider>().isChanged = true;
    }
    ;
    return StackWidget();
  }
}

void ClearControl() {
  clearController(name_controller);
  clearController(link_controller);
  clearController(note_controller);
}

class StackWidget extends StatelessWidget {
  _deleteCallback(BuildContext context) {
    context.read<t.RegProvider>().Delete(id_controller.text);

    _reset(context);
  }

  void setFeild(Tuts? value, BuildContext context) {
    // readbyValue.then((value) {
    print("sd" + value!.id.toString());
    context.read<t.RegProvider>().maxcount = value.id!;
    // id_controller.text = value.id.toString();

    name_controller.text = value.name!;
    link_controller.text = value.link!;
    note_controller.text = value.note!;
    date_controller.text = value.date!;

    context.read<CrudProvider>().isChangedclear = true;
    // });
  }

  ShowAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FindDialog(
            title: "Find",
            type: 1,
            okCallback: (value) {
              var values = value[1].toString();
              var i = int.parse(values);
              context.read<t.RegProvider>().maxcount = i;
              print("===>$i");
              context.read<t.RegProvider>().ReadbyValue(values).then(
                (value) {
                  if (value == null) ClearControl();

                  context.read<t.RegProvider>().tuts = value;
                  setFeild(value, context);
                },
              );
            },
          );
        });
  }

  _findCallback(BuildContext context) {
    ShowAlertDialog(context);
  }

  StackWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _clearCallback(contexts) {
      _reset(context);
    }

    return Container(
      height: context.watch<MediaProvider>().height + 100,
      child: Stack(
        children: [
          Positioned(
            height: 90,
            top: 0,
            right: 0,
            width: context.watch<MediaProvider>().width,
            child: CrudAction(
              saveCallback: _saveCallback,
              clearCallback: _clearCallback,
              findCallback: _findCallback,
              deleteCallback: _deleteCallback,
              editCallback: _editCallback,
            ),
          ),
          Positioned(top: 100, left: 0, right: 0, child: WidgetForm()),
        ],
      ),
    );
  }

  void _reset(BuildContext context) {
    context.read<CrudProvider>().isChanged = false;
    ClearControl();
    setMaxcount(context);
  }

  _saveCallback(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      print("==========>sucsse");
      context.read<t.RegProvider>().Create(Tuts(
          null,
          name_controller.text,
          note_controller.text,
          link_controller.text,
          DateTime.now().toString().substring(0, 10)));

      ClearControl();
      context.read<CrudProvider>().isChanged = false;
      setMaxcount(context);
    } else {
      print("==========>Fail");
    }
  }

  _editCallback(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      print("==========>sucsse");
      context.read<t.RegProvider>().Update(Tuts(
          int.parse(id_controller.text),
          name_controller.text,
          note_controller.text,
          link_controller.text,
          DateTime.now().toString().substring(0, 10)));

      ClearControl();
      context.read<CrudProvider>().isChanged = false;
      setMaxcount(context);
    } else {
      print("==========>Fail");
    }
  }

  void setMaxcount(BuildContext context) {
    context.read<t.RegProvider>().getMaxCount().then((value) =>
        {print(value), context.read<t.RegProvider>().maxcount = value!});
  }
}

var name_focus = FocusNode();
var id_focus = FocusNode();
var link_focus = FocusNode();
var note_focus = FocusNode();
var id_controller = TextEditingController();
var name_controller = TextEditingController();
var note_controller = TextEditingController();
var link_controller = TextEditingController();
var date_controller = TextEditingController();

class WidgetForm extends StatefulWidget {
  WidgetForm({Key? key}) : super(key: key);

  @override
  State<WidgetForm> createState() => _WidgetFormState();
}

final _formKey = GlobalKey<FormState>();

class _WidgetFormState extends State<WidgetForm> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    note_controller.text = proces_txt;
    link_controller.text = proces_txt;
    name_controller.text = proces_txt;
  }

  @override
  Widget build(BuildContext context) {
    // _formKey = GlobalKey<FormState>();
    return WidgetForms();
  }

  String password = "";

  Widget WidgetForms() {
    var string = context.watch<t.RegProvider>().maxcount.toString();
    print(string);
    id_controller.text = string;
    // if(_formKey!.currentState!.validate())
    return Form(
      key: _formKey,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: OutlinedButton(
                    onPressed: !(context.read<t.RegProvider>().smallid)
                        ? () {
                            // print("<===>${id_controller.text}");
                            var i = int.parse(id_controller.text) - 1;
                            context.read<t.RegProvider>().maxcount = i;
                            print("===>$i");
                            context
                                .read<t.RegProvider>()
                                .ReadbyValue((i).toString())
                                .then((value) {
                              if (value == null) ClearControl();

                              context.read<t.RegProvider>().tuts = value;
                              setFeild(value);
                            });
                          }
                        : null,
                    child: Container(
                      height: 60,
                      child: Icon(Icons.chevron_left),
                    )),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    child: TextFormField(
                      controller: id_controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Id',
                      ),
                      readOnly: true,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: OutlinedButton(
                    onPressed: (context.read<t.RegProvider>().greatid)
                        ? () {
                            var i = int.parse(id_controller.text) + 1;
                            context.read<t.RegProvider>().maxcount = i;
                            print("===>$i");
                            context
                                .read<t.RegProvider>()
                                .ReadbyValue((i).toString())
                                .then((value) {
                              if (value == null) ClearControl();
                              context.read<t.RegProvider>().tuts = value;
                              setFeild(value);
                            });
                          }
                        : null,
                    child: Container(
                      height: 60,
                      child: Icon(Icons.chevron_right),
                    )),
              )
            ],
          ),
        ),

        // using the match validator to confirm password
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: TextFormField(
            focusNode: name_focus,
            controller: name_controller,
            decoration: InputDecoration(
              errorText: basicvalidator(name_controller.text),
              border: OutlineInputBorder(),
              hintText: 'Name',
              suffixIcon: IconButton(
                  onPressed: () {
                    clearController(name_controller);
                  },
                  icon: Icon(Icons.clear)),
            ),
            onChanged: (val) => {textFeildChanged()},
            validator: (value) => basicvalidator(value),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: TextFormField(
            focusNode: link_focus,
            controller: link_controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              errorText: basicvalidator(link_controller.text),
              hintText: 'Link',
              prefixIcon: (getUrl(link_controller.text).isNotEmpty)
                  ? IconButton(
                      onPressed: () async {
                        var text = link_controller.text;
                        if (getUrl(text) != "")
                          await canLaunch(text)
                              ? await launch(text)
                              : throw 'Could not launch $url_';
                      },
                      icon: Icon(Icons.web_sharp))
                  : null,
              suffixIcon: IconButton(
                  onPressed: () {
                    clearController(link_controller);
                  },
                  icon: Icon(Icons.clear)),
            ),
            onChanged: (val) => {textFeildChanged()},
            validator: (value) => basicvalidator(value),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: TextFormField(
            focusNode: note_focus,
            controller: note_controller,
            maxLines: 8,
            onFieldSubmitted: (value) => basicvalidator(value),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    clearController(note_controller);
                  },
                  icon: Icon(Icons.clear)),
              border: OutlineInputBorder(),
              hintText: 'Note',
            ),
            onChanged: (val) => {textFeildChanged()},
            validator: (value) => basicvalidator(value),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: TextFormField(
            readOnly: true,
            controller: date_controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Date',
            ),
          ),
        ),
      ]),
    );
  }

  bool textFeildChanged() => context.read<CrudProvider>().isChanged = true;

  void setFeild(Tuts? value) {
    // readbyValue.then((value) {
    print("sd" + value!.id.toString());
    context.read<t.RegProvider>().maxcount = value.id!;
    // id_controller.text = value.id.toString();

    name_controller.text = value.name!;
    link_controller.text = value.link!;
    note_controller.text = value.note!;
    date_controller.text = value.date!;

    context.read<CrudProvider>().isChangedclear = true;
    // });
  }
}

void clearController(TextEditingController controller) {
  controller.text = "";
}
