import 'dart:io' as io;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shareapks/shareapk.dart';

void main() => runApp(Material(child: MaterialApp(home: start())));

class start extends StatefulWidget {
  const start({Key? key}) : super(key: key);

  @override
  State<start> createState() => _startState();
}

class _startState extends State<start> {
  Widget _mywidget = Container();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _mywidget,
          Container(
            child: Center(
                child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => shareme()));
              },
              child: Text("Share"),
            )),
          ),
        ],
      ),
    );
  }
}

class shareme extends StatelessWidget {
  const shareme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [if (io.Platform.isAndroid) Share()],
        ),
      ),
    );
  }
}
