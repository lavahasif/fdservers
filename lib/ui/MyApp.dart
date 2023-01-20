import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../provider/MedaProvider.dart';
import '../provider/MyProvider.dart';
import '../provider/UploadProvider.dart';
import '../service/Service.dart';
import 'IpWidget.dart';
import 'NoteRegistration.dart';
import 'Settings.dart';
import 'Signal.dart';
import 'SocketIO.dart';
import 'Upload.dart';
import 'share.dart';

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    var title2 = 'Utility App';
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title2,
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(),
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(
          title: title2,
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  onPressed() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("id",
        textcontroller!.text.isEmpty ? "localhost" : textcontroller!.text);
  }

  void _launchURL() async => await canLaunch(url_)
      ? await launch(url_)
      : throw 'Could not launch $url_';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.read<MediaProvider>().height = size.height;
    context.read<MediaProvider>().width = size.width;
    textcontroller!.text = url_;
    // var iptext = context.watch<MyProvider>()._iptext;
    // _textcontroller.text = iptext;
    // _textcontroller.tefxt = iptext;
    // print(iptext);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            height: 48,
            width: 48,
            child: IconButton(
              icon: Icon(
                Icons.signal_cellular_alt,
                size: 30,
              ),
              color: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SocketIo()));
              },
            ),
          ),
          Container(
            height: 48,
            width: 48,
            child: IconButton(
              icon: Icon(
                Icons.message_outlined,
                size: 30,
              ),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Signal()));
              },
            ),
          ),
          Container(
            height: 48,
            width: 48,
            child: IconButton(
              icon: Icon(
                Icons.cloud_upload,
                size: 30,
              ),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Upload()));
              },
            ),
          ),
          Container(
            height: 48,
            width: 48,
            child: IconButton(
              icon: Icon(
                Icons.share,
                size: 30,
              ),
              color: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => shareme()));
              },
            ),
          ),
          Container(
            height: 48,
            width: 48,
            child: IconButton(
              icon: Icon(
                Icons.note_add_sharp,
                size: 30,
              ),
              color: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegRoute()));
              },
            ),
          ),
          Container(
            height: 48,
            width: 48,
            child: IconButton(
              icon: Icon(
                Icons.developer_board,
                size: 30,
              ),
              color: Colors.white,
              onPressed: () {
                ShareService().opendeveloper();
              },
            ),
          )
        ],
        title: Text(widget.title),
      ),

      body: FirstPage(context),
      floatingActionButton: FloatingActionButton(
        onPressed: _launchURL,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Padding FirstPage(BuildContext context) {
    var value2 = prefs.getBool("isd") ?? false;
    context.read<UploadProvider>().isde = value2;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          // Positioned(
          //     height: 25,
          //     left: 0,
          //     right: 0,
          //     top: 0,
          //     child:SingleChildScrollView(child: wid) ),
          Positioned(
            height: 60,
            left: 0,
            right: 0,
            top: 0,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text("Delete After Upload"),
                ),
                Expanded(
                  flex: 2,
                  child: Checkbox(
                    onChanged: (va) {
                      prefs.setBool("isd", va!);
                      context.read<UploadProvider>().isde = va;
                      setState(() {
                        value2 = va;
                      });
                    },
                    value: value2,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Settings()));
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            height: MediaQuery.of(context).size.height - 190,
            left: 0,
            right: 0,
            top: 70,
            child: ListView(
              children: <Widget>[
                if (proces_txt.length > 0) wid,
                TextWidget(),
                // Consumer<MyProvider>(
                //     builder: (_, da, __) => TextWidget(
                //           da,
                //         )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                        onLongPress: () {
                          context.read<MyProvider>().iptext = url_;
                          // setState(() {
                          print("==>" + url_);
                          // textcontroller!.text = url_;
                          // });
                        },
                        onPressed: () async {
                          // SharedPreferences prefs =
                          // await SharedPreferences.getInstance();
                          await prefs.setString(
                              "id",
                              textcontroller!.text.isEmpty
                                  ? "localhost"
                                  : textcontroller!.text);
                          print(prefs.getString("id"));
                          setState(() {
                            address = textcontroller!.text;
                            url_ = 'http://$address:8081';
                          });
                        },
                        child: Text("Save")),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.redAccent)),
                            onPressed: () {
                              server.close(force: true);
                            },
                            child: Text("Stop")),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green)),
                            onPressed: () async {
                              print(prefs.get("id"));
                              try {
                                server = await shelf_io.serve(
                                    Cascade().add(app).handler,
                                    prefs.get("id"),
                                    8081);
                                // Enable content compression
                                server.autoCompress = true;

                                print(
                                    'Serving at http://${server.address.host}:${server.port}');
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Text("Start")),
                      ),
                    ),
                  ],
                ),
                IpWidget()
              ],
            ),
          ),
          context.watch<MyProvider>().loading
              ? Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  TextWidget() {
    textcontroller!.text = context.watch<MyProvider>().iptext;
    // textcontroller!.text = da.iptext;
    if (i) {
      textcontroller!.text = url_;
      i = false;
    }
    // _textcontroller.text = da._iptext;
    // print("jj"+da.iptext);

    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'IP',
      ),
      controller: textcontroller,
    );
  }
}
