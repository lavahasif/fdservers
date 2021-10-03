import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestWidget_2 extends StatelessWidget {
  const TestWidget_2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Enter Text',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Enter Text',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Enter Text',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Enter Text',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Enter Text',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Enter Text',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Enter Text',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Enter Text',
            ),
          )
        ],
      ),
    );
  }
}

class TestWidget_3 extends StatelessWidget {
  const TestWidget_3({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: TestWidget_2(),
      ),
    );
  }
}


class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  String? _email;
  String? _password;
  TextStyle style = TextStyle(fontSize: 25.0);

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          prefixIcon: Icon(Icons.add),
          hintText: "Email",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 32.0),
              borderRadius: BorderRadius.circular(97.0))),
      onChanged: (value) {
        setState(() {
          _email = value;
        });
      },
    );
    final passwordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          prefixIcon: Icon(Icons.add),
          hintText: "Password",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 32.0),
              borderRadius: BorderRadius.circular(25.0))),
      onChanged: (value) {
        setState(() {
          _password = value;
        });
      },
    );

    return Center(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.yellow[300],
            height: 300.0,
          ),
          emailField,
          passwordField
        ],
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: MyLoginPage(title: 'Flutter Demo Home Page'),
        ));
  }
}