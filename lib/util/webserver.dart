import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:android_util/android_ip.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as hp;
import 'package:mime/mime.dart' as mime;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as r;
import 'package:shelf_static/shelf_static.dart';
import 'package:untitled1/repository/AppDatabase.dart';
import 'package:untitled1/util/Constants.dart';

import '../main.dart';
import '../main.dart' as d;

class id implements Process {
  @override
  // TODO: implement exitCode
  Future<int> get exitCode => throw UnimplementedError();

  @override
  bool kill([ProcessSignal signal = ProcessSignal.sigterm]) {
    // TODO: implement kill
    throw UnimplementedError();
  }

  @override
  // TODO: implement pid
  int get pid => throw UnimplementedError();

  @override
  // TODO: implement stderr
  Stream<List<int>> get stderr => throw UnimplementedError();

  @override
  // TODO: implement stdin
  IOSink get stdin => throw UnimplementedError();

  @override
  // TODO: implement stdout
  Stream<List<int>> get stdout => throw UnimplementedError();
}

Future<void> Initial() async {
  initializeDatabase();
  prefs = await SharedPreferences.getInstance();
  mfav_port = prefs.getString(Constants.FAVPORT) ?? "8069";
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

  var status = await Permission.storage.status;

  if (await Permission.storage.request().isGranted) {
    if (androidInfo.version.sdkInt > 29) {
      if (await Permission.manageExternalStorage.status.isGranted) {
        database = await $FloorAppDatabase
            .databaseBuilder('app_database.db')
            .addMigrations([migration1to2]).build();
        notesdao = database?.notesdao;
        tutsdao = database?.tutsdao;
        // notesdao?.insertNotes(Notes(null, "asif", "DSf", "ds", "d"));
        //
        // notesdao
        //     ?.findAllNotess()
        //     .then((List<Notes> value) => value.forEach((element) {
        //           print("==========>" + element.toString());
        //         }));
      } else {
        await AndroidIp.EnableStoragePermission;
      }
    } else {
      database =
          await $FloorAppDatabase.databaseBuilder('app_database.db').addMigrations([migration1to2]).build();
      notesdao = database!.notesdao;
      tutsdao = database?.tutsdao;
      // notesdao.insertNotes(Notes(null, "asif", "DSf", "ds", "d"));
      //
      // notesdao
      //     .findAllNotess()
      //     .then((List<Notes> value) => value.forEach((element) {
      //           print("==========>" + element.toString());
      //         }));
    }
  }

  textcontroller = new TextEditingController(text: url_);
  address = '25.86.151.26';
  address = prefs.getString("id") ?? "localhost";
  print(address);
  final Directory? docDir = await getExternalStorageDirectory();

  app = Routers();

  app.mount("/", createStaticHandler(docDir!.path));

  // var address = '192.168.231.159';
  // var address = '10.0.2.16';
  // var address = 'localhost';
  // address = '25.86.151.26';
  url_ = 'http://$address:8081';
  // this needed for static and api type respone
  // final virDirCascade = ShelfVirtualDirectory(docDir!.path).cascade;
  // var handler2 = virDirCascade.add(app).handler;
  try {
    server = await shelf_io.serve(Cascade().add(app).handler, address, 8081);
    // Enable content compression
    server.autoCompress = true;

    print('Serving at http://${server.address.host}:${server.port}');
  } catch (e) {
    print(e);
  }
  print("sdf---->" + url_);
  textcontroller!.text = url_;
}

void showClientList() async {
  // WiFiForIoTPlugin.isEnabled().then((val) {
  //   // _isEnabled = val;
  // });
  /// Refresh the list and show in console
  // getClientList(false, 300).then((val) => val.forEach((oClient) {
  //   print("************************");
  //   print("Client :");
  //   print("ipAddr = '${oClient.ipAddr}'");
  //   print("hwAddr = '${oClient.hwAddr}'");
  //   print("device = '${oClient.device}'");
  //   print("isReachable = '${oClient.isReachable}'");
  //   print("************************");
  // }));
}

r.Router Routers() {
  var app = r.Router();
  app.get('/home', (Request request) async {
    final imageBytes = await rootBundle.load("assets/files/index.html");
    File fi = await writeToFile(imageBytes, "index.html");
    final headers = await _defaultFileheaderParser(fi);
    return Response(200, body: fi.openRead(), headers: headers);
  });
  app.get('/', (Request request) async {
    final imageBytes = await rootBundle.load("assets/files/index.html");
    File fi = await writeToFile(imageBytes, "index.html");
    final headers = await _defaultFileheaderParser(fi);
    return Response(200, body: fi.openRead(), headers: headers);
  });
  app.get('/bim', (Request request) async {
    final imageBytes = await rootBundle.load("assets/files/bim.html");
    File fi = await writeToFile(imageBytes, "bim.html");
    final headers = await _defaultFileheaderParser(fi);
    return Response(200, body: fi.openRead(), headers: headers);
  });
  app.get('/upload', (Request request) async {
    final imageBytes = await rootBundle.load("assets/files/upload.html");
    File fi = await writeToFile(imageBytes, "upload.html");
    final headers = await _defaultFileheaderParser(fi);
    return Response(200, body: fi.openRead(), headers: headers);
  });
  app.get('/api/uploadtest', (Request request) async {
    final imageBytes = await rootBundle.load("assets/img_2.png");
    File fi = await writeToFile(imageBytes, "img_2.png");
    var request =
    http.MultipartRequest('POST', Uri.parse('$address:8081/api/upload'));
    request.files.add(await http.MultipartFile.fromPath('image', fi.path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Response.ok("File Uploaded");
    } else {
      print(response.reasonPhrase);
      Response.notFound(response.reasonPhrase);
    }
    await Response.ok("File Uploaded");
  });
  app.post('/api/upload', (Request request) async {
    // second(request);

    return await third(request);
    // await fst(request);
  });
  app.get('/i', (Request request) async {
    final imageBytes = await rootBundle.load("assets/files/img.png");
    File fi = await writeToFile(imageBytes, "img.png");
    final headers = await _defaultFileheaderParser(fi);
    return Response(200, body: fi.openRead(), headers: headers);
  });
  app.get('/files', (Request request) async {
    final Directory? docDir = await getExternalStorageDirectory();
    List<FileSystemEntity> files = docDir!.listSync(recursive: true);
    String data = "";
    files.forEach((element) {
      var s = element.statSync();
      var filename =
          element.resolveSymbolicLinksSync().toString().split("/").last;
      var size = s.size.toDigital;
      data +=
          '       <div class="col-md-4 col-sm-4 col-lg-3 col-6 m-2" align="center"> <div class="card" style="width: 18rem;"> <div class="card-body"> <p style="font-size: 13px;color: #1b6d85" class="card-title">${filename}</p> <p class="card-text">${s.modified.toString()}</p> <p class="card-text">${size}</p> <a href="/${filename}" class="btn btn-primary">Download</a> </div> </div> </div>';
      // data += filename + s.size.toString() + s.type.toString() + "\n";
    });
    // return Response.ok('\n $data');
    final imageBytes = await rootBundle.loadString("assets/files/files.html");
    var datas = imageBytes.replaceAll("<!--        content-->", data);

    File fi = await writeToFile2(datas, "files.html");
    final headers = await _defaultFileheaderParser(fi);
    return Response(200, body: fi.openRead(), headers: headers);
  });
  app.get('/notes', (Request request) async {
    String data = "";
    var files = await database?.notesdao.findAllNotess();
    files!.forEach((element) {
      data +=
          '       <div class="col-md-4 col-sm-4 col-lg-3 col-6 m-2" align="center"> <div class="card" style="width: 18rem;"> <div class="card-body"> <p style="font-size: 13px;color: #1b6d85" class="card-title">${element.name}${element.id}</p> <p class="card-text">${element.note}</p> <p class="card-text">${element.link}${element.date}</p> <button  onclick="myFunction(`${element.link}+${element.name}+${element.note}`)" class="btn btn-primary">Copy</button> </div> </div> </div>';
      // data += filename + s.size.toString() + s.type.toString() + "\n";
    });
    // return Response.ok('\n $data');
    final imageBytes = await rootBundle.loadString("assets/files/files.html");
    var datas = imageBytes
        .replaceAll("<h1>My Files</h1>", "<h1>My Notes</h1>")
        .replaceAll("<!--        content-->", data);

    File fi = await writeToFile2(datas, "files.html");
    final headers = await _defaultFileheaderParser(fi);
    return Response(200, body: fi.openRead(), headers: headers);
  });

  app.get('/bootstrap', (Request request) async {
    final imageBytes = await rootBundle.load("assets/files/self.html");
    File fi = await writeToFile(imageBytes, "self.html");
    final headers = await _defaultFileheaderParser(fi);
    return Response(200, body: fi.openRead(), headers: headers);
  });
  app.get('/n404', (Request request) async {
    final imageBytes = await rootBundle.load("assets/files/404.html");
    File fi = await writeToFile(imageBytes, "404.html");
    final headers = await _defaultFileheaderParser(fi);
    return Response(200, body: fi.openRead(), headers: headers);
  });
  app.get('/api/set/<name>', (Request request, String name) async {
    final imageBytes = await rootBundle.load("assets/files/self.html");
    File fi = await writeToFile(imageBytes, "self.html");
    final headers = await _defaultFileheaderParser(fi);
    return Response.ok('$name hello Api ${request.requestedUri}');
  });

  app.get('/u', (Request request, String user) {
    return Response(200,
        // body: test.htmls,
        headers: {HttpHeaders.contentTypeHeader: 'text/html'});
  });
  return app;
}

Future<Map<String, Object>> _defaultFileheaderParser(File file) async {
  final fileType = mime.lookupMimeType(file.path);

  // collect file data
  final fileStat = await file.stat();

  // check file permission
  if (fileStat.modeString()[0] != 'r') return {};

  return {
    HttpHeaders.contentTypeHeader: fileType ?? 'application/octet-stream',
    HttpHeaders.contentLengthHeader: fileStat.size.toString(),
    HttpHeaders.lastModifiedHeader: hp.formatHttpDate(fileStat.modified),
    HttpHeaders.acceptRangesHeader: 'bytes'
  };
}

writeToFile2(String imageBytes, String file) async {
  Directory? tempDir = await getExternalStorageDirectory();
  String? tempPath = tempDir?.path;
  var filePath =
      tempPath! + '/' + file; // file_01.tmp is dump file, can be anything
  return new File(filePath).writeAsString(imageBytes);
}

Future<Response> third(Request request) async {
  List<int> dataBytes = [];
  await for (var data in request.read()) {
    dataBytes.addAll(data);
  }

  String fileExtension = '';
  late File file;
  var header2 = request.headers['content-type'];
  var header = HeaderValue.parse(header2!);
  final transformer =
  new mime.MimeMultipartTransformer(header.parameters['boundary']!);
  final bodyStream = Stream.fromIterable([dataBytes]);
  try {
    final parts = await transformer.bind(bodyStream).toList();
    final part = parts[0];
    if (part.headers.containsKey('content-disposition')) {
      header = HeaderValue.parse(part.headers['content-disposition']!);
      String? filename = header.parameters['filename'] ?? "pic.png";
      final content = await part.toList();
      convert(content[0], filename);
      // originalfilename = header.parameters['filename'];
      // print('originalfilename:' + originalfilename!);
      // fileExtension = p.extension(originalfilename);
      // file = await File('/destination/filename.mp4').create(
      //     recursive:
      //         true); //Up two levels and then down into ServerFiles directory

      // await file.writeAsBytes(content[0]);
      return Response.ok("File Sucesfully Uploaded $filename");
    }
  } catch (e) {
    print(e);
    return Response.notFound(e.toString() + "\n Empty File");
  }
  return Response.notFound("Empty File");
}

Future<void> five(Request args) async {
  // final maybeMultipart = args.parts;
  // if (maybeMultipart.isNone)
  //   return const ResponseBodyString("bad POST request: not multipart")
  //       .toResponse(statusCode: HttpStatus.badRequest);
  // final multipart = maybeMultipart.getOrThrow.map(HttpMultipartFormData.parse);
  // final formData = (await multipart.toList())[0];
  // if (!formData.isBinary)
  //   const ResponseBodyString("bad POST request: expected binary data")
  //       .toResponse(statusCode: HttpStatus.badRequest);
  // // ignore: avoid_as
  // final untypedData =
  //     await formData.map((dynamic d) => d as Uint8List).toList();
  // final data = Uint8List.fromList(untypedData.flatten().toList());
  // final either =
  //     EventLog.rw.deserialize(data.asByteData, 0).map((di) => di.value);
  // return respondHtml(renderParseLogFile(Some(either)));
}

Future<void> four(Request request) async {
  List<int> dataBytes = [];
  await for (var data in request.read()) {
    dataBytes.addAll(data);
  }

  String fileExtension = '';
  late File file;
  var header2 = request.headers['content-type'];
  var header = HeaderValue.parse(header2!);
  final transformer =
  new mime.MimeMultipartTransformer(header.parameters['boundary']!);
  transformer.bind(request.read());
  final bodyStream = Stream.fromIterable([dataBytes]);
  final parts = await transformer.bind(bodyStream).toList();
  final part = parts[0];
  if (part.headers.containsKey('content-disposition')) {
    header = HeaderValue.parse(part.headers['content-disposition']!);
    String? filename = header.parameters['filename'] ?? "pic.png";
    final content = await part.toList();

    convert(content, filename);
    // originalfilename = header.parameters['filename'];
    // print('originalfilename:' + originalfilename!);
    // fileExtension = p.extension(originalfilename);
    // file = await File('/destination/filename.mp4').create(
    //     recursive:
    //         true); //Up two levels and then down into ServerFiles directory

    // await file.writeAsBytes(content[0]);
  }
}

void second(Request request) {
  gzip.decoder.bind(request.read()).drain();
  // if (!request.isMultipart)
  //   return Response(400);
  //  // var single = await request.read();
  //
  // await  for (final part in request.parts) {
  //    // var s= Uint8List.fromList(part.);
  //    // writeToFile(s.buffer.asByteData(),"pic.png");
  //
  //    // Deal with the part
  //  }
  //  return Response(200);

  // var boundary = request.headers;
  // String? value = request.headers['content-type'];
  // var header = HeaderValue.parse(value!);
  // String fileExtension = '';
  // late File file;
  // final transformer =
  //     new mime.MimeMultipartTransformer(header.parameters['boundary']!);
  // final bodyStream = Stream.fromIterable([dataBytes]);
  // final parts = await transformer.bind(bodyStream).toList();
  // final part = parts[0];
  // var content = await part.toList();
  // convert();

  // if (part.headers.containsKey('content-disposition')) {
  //   header = HeaderValue.parse(part.headers['content-disposition']!);
  //   originalfilename = header.parameters['filename'];
  //   print('originalfilename:' + originalfilename!);
  //   fileExtension = p.extension(originalfilename);
  //   file = await File('/destination/filename.mp4')
  //       .create(recursive: true); //Up two levels and then down into ServerFiles directory
  //   final content = await part.toList();
  //   await file.writeAsBytes(content[0]);
  // }
}

void convert(dataBytes, String filename) {
  var s = Uint8List.fromList(dataBytes);
  writeToFile(s.buffer.asByteData(), filename);
}

Future<void> fst(Request request) async {
  List<int> dataBytes = [];
  String? value = request.headers['content-type'];
  var header = HeaderValue.parse(value!);
  var boundary = header.parameters['boundary']!;
  await for (var part in request
      .read()
      .transform(new mime.MimeMultipartTransformer(boundary))) {
    if (part.headers.containsKey('content-disposition')) {
      String? header2 = part.headers['content-disposition'];
      header = HeaderValue.parse(header2!);
      Directory? tempDir = await getExternalStorageDirectory();
      String? tempPath = tempDir?.path;
      var filename = tempPath! + '/' + "pics.png";
      final file = new File(filename);
      IOSink fileSink = file.openWrite();
      await part.pipe(fileSink);
      fileSink.close();
    }
    // dataBytes.addAll(data);
  }
}

Response _echoRequest(Request request) =>
    Response.ok('Request for Kunchol "${request.url}"');

Future<void> initializeDatabase() async {
  // copy db file from Assets folder to Documents folder (only if not already there...)
  // if (FileSystemEntity.typeSync(dbPath) == FileSystemEntityType.notFound) {
  var datab = await rootBundle.load("assets/files/img.png");
  var databi = await rootBundle.load("assets/files/bim.html");
  var data = await rootBundle.load("assets/files/index.html");
  var datas = await rootBundle.load("assets/files/self.html");
  writeToFile(data, "index.html");
  writeToFile(datab, "img.png");
  writeToFile(datas, "self.html");
  writeToFile(databi, "bim.html");

  // }
}

//=======================
Future<File> writeToFiles(ByteData data) async {
  final buffer = data.buffer;
  Directory? tempDir = await getExternalStorageDirectory();
  String? tempPath = tempDir?.path;

  var filePath =
      tempPath! + '/img.png'; // file_01.tmp is dump file, can be anything
  return new File(filePath)
      .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}
//======================

// HERE IS WHERE THE CODE CRASHES (WHEN TRYING TO WRITE THE LOADED BYTES)
Future<File> writeToFile(ByteData data, String file) async {
  final buffer = data.buffer;
  Directory? tempDir = await getExternalStorageDirectory();
  String? tempPath = tempDir?.path;
  var filePath =
      tempPath! + '/' + file; // file_01.tmp is dump file, can be anything
  return new File(filePath)
      .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}

Future<bool> sendFile(String paths, ip) async {
  var headers = {'accept': '*/*', 'Content-Type': 'multipart/form-data'};
  var request = http.MultipartRequest(
      'POST', Uri.parse('http://$ip:$mfav_port/fileupload'));
  request.files.add(await http.MultipartFile.fromPath('files', paths));
  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        return true;
      } else {
        print(response.reasonPhrase);
        return false;
      }
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> sendText(String data, ip) async {
  var headers = {'accept': '*/*', 'Content-Type': 'application/json'};
  var request = http.Request(
      'POST', Uri.parse('http://$ip:$mfav_port/api/ApiUpload/text'));
  var encode = json.encode(data);
  request.body = encode;
  print(encode);

  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  } catch (e) {
    print(e);
    return false;
  }
}

String getUrl(String text) {
  final urlRegExp = new RegExp(
      r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
  final urlMatches = urlRegExp.allMatches(text);
  List<String> urls = urlMatches
      .map((urlMatch) => text.substring(urlMatch.start, urlMatch.end))
      .toList();
  urls.forEach((x) => print(x));
  var url = "";
  try {
    url = urls[0];
    ;
    print(url);
  } catch (e) {
    url = "";
  }
  return ((url != null) ? url : "");
}
// // The location of the SignalR Server.
// final serverUrl = "192.168.10.50:51001";
// // Creates the connection by using the HubConnectionBuilder.
// final hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
// // When the connection is closed, print out a message to the console.
// final hubConnection.onclose( (error) => print("Connection Closed"));