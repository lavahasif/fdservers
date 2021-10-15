import 'dart:async';
import 'dart:io' as soc;
import 'dart:isolate';

import 'package:android_util/android_ip.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/component/FindDialog.dart';
import 'package:untitled1/provider/MyProvider.dart';
import 'package:untitled1/ui/Whatsappopen.dart';

import '../main.dart';
import 'TutsRegistration.dart';

Isolate? geek;

void main() {
  runApp(IpWidget());
}

class IpWidget extends StatefulWidget {
  @override
  _IpWidgetState createState() => _IpWidgetState();
}

class _IpWidgetState extends State<IpWidget> {
  String _Connecton_change = '';
  String _IpWT = 'Unknown';
  String _rootWoT = 'Unknown';
  String _IpAddress_Wifi = 'Unknown';
  String _IpAddress_Private = 'Unknown';
  String _IpAddress_USB_tether = 'Unknown';
  String _IpAddress_All = 'Unknown';
  String _IpAddress_Cellular2 = 'Unknown';
  String _IpAddress_Cellular1 = 'Unknown';
  String _IpAddress_Cell = 'Unknown';
  String _IpAddress_Blue_ther = 'Unknown';
  String _storage = 'Unknown';
  var _ondeviceconnected2 = [];

  var _items2;

  get _changed => null;

  get dropdownValue => null;

  List<DropdownMenuItem>? getItem() {
    int index = 0;

    return [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ].map((value) {
      index++;
      return DropdownMenuItem(
        value: index,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [Text(value), Text(index.toString())],
        ),
      );
    }).toList();
  }

  var listner = androidip.onConnectivityChanged;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    listner = null;
  }

  @override
  void initState() {
    super.initState();

    listner!.listen((event) {
      setState(() {
        _Connecton_change = event;
      });
      initPlatformState();
    });

    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String Ip_Wifi_tether;
    String root;
    String IpAddress_Wifi;
    String IpAddress_Private;
    String IpAddress_USB_tether;
    String IpAddress_Cellular1;
    String IpAddress_Cellular2;
    String IpAddress_Blue_ther;
    String IpAddress_All;
    String _ondeviceconnected2 = '';
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      Ip_Wifi_tether =
          await AndroidIp.IpAddress_Wifi_tether ?? 'Unknown Number';
      print(Ip_Wifi_tether);
      root = await AndroidIp.IpAddress_Wifi_tetherorwifi ?? 'Unknown Number';
      IpAddress_Wifi = await AndroidIp.IpAddress_Wifi ?? 'Unknown Number';
      IpAddress_Private = await AndroidIp.IpAddress_Private ?? 'Unknown Number';
      var networkResult = (await AndroidIp.networkresult);
      IpAddress_USB_tether = networkResult!.Usb
          // await AndroidIp.IpAddress_USB_tether
          ??
          'Unknown Number';
      IpAddress_Cellular1 =
          await AndroidIp.IpAddress_Cellular1 ?? 'Unknown Number';
      IpAddress_Cellular2 =
          await AndroidIp.IpAddress_Cellular2 ?? 'Unknown Number';
      IpAddress_Blue_ther =
          await AndroidIp.IpAddress_Blue_ther ?? 'Unknown Number';
      IpAddress_All = await AndroidIp.IpAddress_All ?? 'Unknown Number';
      _storage =
          await ExtStorage.getExternalStorageDirectory() ?? 'Unknown Number';
    } on PlatformException {
      root = 'Failed to get ';
      Ip_Wifi_tether = 'Failed to get ';
      IpAddress_Wifi = 'Failed to get ';
      IpAddress_Private = 'Failed to get ';
      IpAddress_USB_tether = 'Failed to get ';
      IpAddress_Cellular1 = 'Failed to get ';
      IpAddress_Cellular2 = 'Failed to get ';
      IpAddress_Blue_ther = 'Failed to get ';
      IpAddress_All = 'Failed to get ';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _IpWT = Ip_Wifi_tether;
      _rootWoT = root;
      _IpAddress_Wifi = IpAddress_Wifi;
      _IpAddress_Private = IpAddress_Private;
      _IpAddress_USB_tether = IpAddress_USB_tether;
      _IpAddress_Cellular1 = IpAddress_Cellular1;
      _IpAddress_Cellular2 = IpAddress_Cellular2;
      _IpAddress_Blue_ther = IpAddress_Blue_ther;
      _IpAddress_All = IpAddress_All;
      _storage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Changes on: $_Connecton_change\n'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(flex: 4, child: Text('Wifi on: $_IpAddress_Wifi\n')),
            SizedBox(
              width: 25,
            ),
            Expanded(
              flex: 2,
              child: RaisedButton(
                  color: Colors.blue,
                  child: copyWidget(),
                  onPressed: () => _copy(_IpAddress_Wifi)),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(flex: 4, child: Text('Wifi_tether on: $_IpWT\n')),
            SizedBox(
              width: 25,
            ),
            Expanded(
              flex: 2,
              child: RaisedButton(
                  color: Colors.blue,
                  child: copyWidget(),
                  onPressed: () => _copy(_IpWT)),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(flex: 4, child: Text('w/t bothon: $_rootWoT\n')),
            SizedBox(
              width: 25,
            ),
            Expanded(
              flex: 2,
              child: RaisedButton(
                  color: Colors.blue,
                  child: copyWidget(),
                  onPressed: () => _copy(_rootWoT)),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Private on: $_IpAddress_Private\n'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                flex: 4, child: Text('Cellular on: $_IpAddress_Cellular1\n')),
            SizedBox(
              width: 25,
            ),
            Expanded(
              flex: 2,
              child: RaisedButton(
                  color: Colors.blue,
                  child: copyWidget(),
                  onPressed: () => _copy(_IpAddress_Cellular1)),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Cellular2 on: $_IpAddress_Cellular2\n'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                flex: 4,
                child: Text('USB_tether on: $_IpAddress_USB_tether\n')),
            SizedBox(
              width: 25,
            ),
            Expanded(
              flex: 2,
              child: RaisedButton(
                  color: Colors.blue,
                  child: copyWidget(),
                  onPressed: () => _copy(_IpAddress_USB_tether)),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: Text('==>: $_storage\n')),
            Expanded(child: Text('All: $_IpAddress_All\n')),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                flex: 4,
                child: Text('Bluetooth_tether on: $_IpAddress_Blue_ther\n')),
            Expanded(
              flex: 2,
              child: RaisedButton(
                  color: Colors.blue,
                  child: copyWidget(),
                  onPressed: () => _copy(_IpAddress_Blue_ther)),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ..._ondeviceconnected2,
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 63,
                    child: RaisedButton(
                        color: Colors.blue,
                        child: Text("Show Device",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () => setLisIp()),
                  ),
                ),
                SizedBox(width: 25),
                Expanded(
                  child: Container(
                    height: 63,
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text("Share Me",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        setShare();
                      },
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 63,
                    child: RaisedButton(
                        color: Colors.blue,
                        child: Text("Show Port",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () => ShowAlertDialog_port(context)),
                  ),
                ),
                SizedBox(width: 25),
                Expanded(
                  child: Container(
                    height: 63,
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text("Ping Ip",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        ShowAlertDialog_ping(context);
                      },
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 63,
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text("IP Scan",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        ShowAlertDialog_ping_ip(context);
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 63,
                child: RaisedButton(
                    color: Colors.blue,
                    child: Text("Tuts Regis",
                        style: TextStyle(color: Colors.white)),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RegRoute()))),
              ),
            ),
            SizedBox(width: 25),
            Expanded(
              child: Container(
                height: 63,
                child: RaisedButton(
                    color: Colors.blue,
                    child:
                        Text("WhatsApp", style: TextStyle(color: Colors.white)),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WhatsAppopen()))),
              ),
            ),
          ],
        ),
        SizedBox(height: 25),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: DropdownButton(
                  style: TextStyle(color: Colors.deepPurple),
                  icon: Align(
                      alignment: Alignment.centerRight,
                      child: const Icon(Icons.arrow_downward)),
                  value: getItem()![0].value,
                  items: getItem(),
                  onChanged: (dynamic newValue) {
                    setState(() {
                      // dropdownValue = newValue!;
                    });
                  }),
            ),
            Expanded(
              flex: 6,
              child: Text(""),
            ),
          ],
        )
      ],
    );
  }

  ShowAlertDialog_port(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FindDialog(
            type: 1,
            title: "Port Scan",
            okCallback: (value) {
              var port = value[1].toString();
              setLisIp2(int.parse(port));
              print("===>$port");
            },
          );
        });
  }

  ShowAlertDialog_ping(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FindDialog(
            title: "Ping",
            okCallback: (value) {
              var ip = value[1].toString();
              var port = value[2].toString();

              setLisIp_ip_port(int.parse(port), ip);
              print("=+==>$ip");
            },
            type: 2,
          );
        });
  }

  var myips = "";

  ShowAlertDialog_ping_ip(BuildContext context) {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FindDialog(
            title: "Ping",
            okCallback: (value) {

              var ip = value[1].toString();
              var port = value[2].toString();
              var arguments = {'ip': '$ip', 'timeout': '$mfav2_timeout'};
              myips = ip;
              setState(() {
                counts = 0;
                _ondeviceconnected2.clear();
                _ondeviceconnected2.add(Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("SlNo"),
                    GestureDetector(child: Text("Devices")),
                    Column(
                      children: [
                        Text("$port"),
                      ],
                    ),
                  ],
                ));
              });
              androidip.onIpConnected(arguments)!.listen((event) {
                print(event);
                setLisIp_ip_port2(int.parse(port), event);
              });

              print("=+==>$ip");
            },
            type: 2,
          );
        });
  }

  setLisIp() {
    setState(() {
      _ondeviceconnected2.clear();
      _ondeviceconnected2.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("SlNo"),
          GestureDetector(child: Text("Devices")),
          Column(
            children: [
              Text("$mfav_port"),
            ],
          ),
          Column(
            children: [
              Text("8081"),
            ],
          ),
          Column(
            children: [
              Text("1433"),
            ],
          ),
        ],
      ));
    });
    var count = 0;

    var da = new AndroidIp().onDeviceConnected!.listen((event) async {
      var ip = event;
      var ischecked = false;
      var is8081 = false;
      var is1433 = false;
      try {
        var socket = await soc.Socket.connect(ip, int.parse(mfav_port),
            timeout: Duration(milliseconds: int.parse(mfav_timeout)));
        socket.close();
        ischecked = true;
      } catch (e) {
        // print(e);
      }
      try {
        var socket = await soc.Socket.connect(ip, 8081,
            timeout: Duration(milliseconds: int.parse(mfav_timeout)));
        socket.close();
        is8081 = true;
      } catch (e) {
        // print(e);
      }
      try {
        var socket = await soc.Socket.connect(ip, 1433,
            timeout: Duration(milliseconds: int.parse(mfav_timeout)));
        socket.close();
        is1433 = true;
      } catch (e) {
        // print(e);
      }

      setState(() {
        count++;
        _ondeviceconnected2.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("$count"),
            GestureDetector(
                onDoubleTap: () {
                  _copy(ip);
                },
                onTap: () {
                  context.read<MyProvider>().launchURL('http://$ip:$mfav_port');
                },
                child: Text("$ip")),
            Column(
              children: [
                // Text("$mfav_port"),
                Checkbox(value: ischecked, onChanged: (_) {}),
              ],
            ),
            GestureDetector(
              onLongPress: () {
                context.read<MyProvider>().launchURL('http://$ip:8081');
              },
              child: Column(
                children: [
                  // Text("8081"),
                  Checkbox(value: is8081, onChanged: (_) {})
                ],
              ),
            ),
            Column(
              children: [
                // Text("1433"),
                Checkbox(value: is1433, onChanged: (_) {})
              ],
            ),
          ],
        ));
      });
    });
  }

  setLisIp2(int port) {
    setState(() {
      _ondeviceconnected2.clear();
      _ondeviceconnected2.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("SlNo"),
          GestureDetector(child: Text("Devices")),
          Column(
            children: [
              Text("$port"),
            ],
          ),
        ],
      ));
    });
    var count = 0;

    var da = new AndroidIp().onDeviceConnected!.listen((event) async {
      var ip = event;
      var ischecked = false;
      var is8081 = false;
      var is1433 = false;
      try {
        var socket = await soc.Socket.connect(ip, port,
            timeout: Duration(milliseconds: int.parse(mfav_timeout)));
        socket.close();
        ischecked = true;
      } catch (e) {
        // print(e);
      }

      setState(() {
        count++;
        _ondeviceconnected2.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("$count"),
            GestureDetector(
                onDoubleTap: () {
                  _copy(ip);
                },
                onTap: () {
                  context.read<MyProvider>().launchURL('http://$ip:$port');
                },
                child: Text("$ip")),
            Column(
              children: [
                // Text("$mfav_port"),
                Checkbox(value: ischecked, onChanged: (_) {}),
              ],
            ),
          ],
        ));
      });
    });
  }

  setLisIp_ip_port(int port, String ip) async {
    setState(() {
      _ondeviceconnected2.clear();
      _ondeviceconnected2.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("SlNo"),
          GestureDetector(child: Text("Devices")),
          Column(
            children: [
              Text("$port"),
            ],
          ),
        ],
      ));
    });
    var count = 0;
    var ischecked = false;
    try {
      var socket = await soc.Socket.connect(ip, port,
          timeout: Duration(milliseconds: int.parse(mfav_timeout)));
      socket.close();
      ischecked = true;
    } catch (e) {
      print(e);
      ischecked = false;
      // print(e);
    }

    setState(() {
      count++;
      _ondeviceconnected2.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("$count"),
          GestureDetector(
              onDoubleTap: () {
                _copy(ip);
              },
              onTap: () {
                context.read<MyProvider>().launchURL('http://$ip:$port');
              },
              child: Text("$ip")),
          Column(
            children: [
              // Text("$mfav_port"),
              Checkbox(value: ischecked, onChanged: (_) {}),
            ],
          ),
        ],
      ));
    });
  }

  var counts = 0;

  setLisIp_ip_port2(int port, String ip) async {
    var ischecked = false;
    try {
      var socket = await soc.Socket.connect(ip, port,
          timeout: Duration(milliseconds: int.parse(mfav_timeout)));
      socket.close();
      ischecked = true;
    } catch (e) {
      print(e);
      ischecked = false;
      // print(e);
    }

    setState(() {
      counts++;
      _ondeviceconnected2.add(Container(
        color: myips == ip ? Colors.lightBlue : Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("$counts"),
            GestureDetector(
                onDoubleTap: () {
                  _copy(ip);
                },
                onTap: () {
                  context.read<MyProvider>().launchURL('http://$ip:$port');
                },
                child: Text("$ip")),
            Column(
              children: [
                // Text("$mfav_port"),
                Checkbox(value: ischecked, onChanged: (_) {}),
              ],
            ),
          ],
        ),
      ));
    });
  }

  setShare() {
    var da = new AndroidIp().onShared!.listen((event) {
      if (event.toString() == "Progress")
        context.read<MyProvider>().loading = true;
      else
        context.read<MyProvider>().loading = false;
    });
  }

  void _copy(String ipAddress_Wifi) {
    context.read<MyProvider>().iptext = ipAddress_Wifi;
    var clipboardData = ClipboardData(text: ipAddress_Wifi);

    Clipboard.setData(clipboardData);
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Copied")));
  }

  void start_geek_process() async {
    // port for isolate to receive messages.
    ReceivePort geekReceive = ReceivePort();

    // Starting an isolate
    geek = await Isolate.spawn(gfg, geekReceive.sendPort);
  }

  void gfg(SendPort sendPort) {
    int counter = 0;

    // Printing Output message after every 2 sec.
    Timer.periodic(new Duration(seconds: 2), (Timer t) {
      // Increasing the counter
      counter++;

      //Printing the output message
      soc.stdout.writeln('Welcome to GeeksForGeeks $counter');
    });
  }
}

class copyWidget extends StatelessWidget {
  const copyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Copy",
      style: TextStyle(color: Colors.white),
    );
  }
}
