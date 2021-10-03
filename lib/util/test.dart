import 'dart:async';

import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shelf/shelf.dart';

extension ReadMultipartRequest on Request {
  bool get isMultipart => _extractMultipartBoundary() != null;

  Stream<MimeMultipart> get parts {
    final boundary = _extractMultipartBoundary();
    if (boundary == null) {
      throw StateError('Not a multipart request.');
    }

    return MimeMultipartTransformer(boundary)
        .bind(read())
        .map((part) =>
        _CaseInsensitiveMultipart(part));
  }

  /// Extracts the `boundary` paramete from the content-type header, if this is
  /// a multipart request.
  String? _extractMultipartBoundary() {
    if (!headers.containsKey('Content-Type')) return null;

    String? header = headers['Content-Type'];
    final contentType = MediaType.parse(header!);
    if (contentType.type != 'multipart') return null;

    return contentType.parameters['boundary'];
  }
}

class _CaseInsensitiveMultipart extends MimeMultipart {
  MimeMultipart _inner;

  _CaseInsensitiveMultipart(this._inner);

  late Map<String, String> _normalizedHeaders;

  @override
  Map<String, String> get headers {
    return _normalizedHeaders = CaseInsensitiveMap.from(_inner.headers);
  }

  @override
  StreamSubscription<List<int>> listen(void Function(List<int> data)? onData,
          {void Function()? onDone, Function? onError, bool? cancelOnError}) =>
      _inner.listen(onData,
          onDone: onDone, onError: onError, cancelOnError: cancelOnError);
}

class test {
  static const String htmls =
      "<!DOCTYPE html> <html> <head> <title>Page Title</title> </head> <body> <h1>This is a Heading</h1> <p>This is a paragraph.</p> </body> </html>";
}
