import 'dart:convert';

import 'package:flutter/services.dart';

/// This service is responsible for talking with the OS to see if anything was
/// shared with the application.
class ShareService {
  void Function(String)? onDataReceived;
  void Function(List<String>)? onFileReceived;

  ShareService() {
    // If sharing causes the app to be resumed, we'll check to see if we got any
    // shared data
    SystemChannels.lifecycle.setMessageHandler((msg) async {
      if (msg?.contains("resumed") ?? false) {
        getSharedText().then((String data) {
          // Nothing was shared with us :(
          if (data == null) {
            return null;
          }

          // We got something! Inform our listener.
          onDataReceived?.call(data);
        });
        getSharedDatafile().then((value) {
          if (value == null) {
            return null;
          }

          // We got something! Inform our listener.
          onFileReceived?.call(value);
        });
      }
      return;
    });
  }

  /// Invoke a method on our platform, telling it to give us any shared data
  /// it has
  Future<String> getSharedText() async {
    return await MethodChannel('com.tnorbury.flutterSharingTutorial')
            .invokeMethod("getSharedDatatext") ??
        "";
  }

  Future<void> setRefresh() async {
    return await MethodChannel('com.tnorb                ury.flutterSharingTutorial')
        .invokeMethod("delete");
  }  

  Future<void> openWhats(mob, message, type) async {
    return await MethodChannel('com.tnorbury.flutterSharingTutorial')
        .invokeMethod("whats",
            {'message': "$message", 'mob': "$mob", 'pacakges': '$type'});
  }

  Future<int> getAndroidVersion() async {
    return await MethodChannel('com.tnorbury.flutterSharingTutorial')
        .invokeMethod("version");
  }

  Future<void> opendeveloper() async {
    return await MethodChannel('com.tnorbury.flutterSharingTutorial')
        .invokeMethod("opendev");
  }

  Future<String> getPath() async {
    return await MethodChannel('com.tnorbury.flutterSharingTutorial')
            .invokeMethod("getPath") ??
        "";
  }

  // Future<Uint8List> getSharedData() async {
  //   return await MethodChannel('com.tnorbury.flutterSharingTutorial')
  //       .invokeMethod("getSharedData") ??
  //       "";
  // }

  Future<List<String>> getSharedDatafile() async {
    return json.decode(
            await MethodChannel('com.tnorbury.flutterSharingTutorial')
                .invokeMethod("getSharedDatafile")) ??
        null;
  }
}
