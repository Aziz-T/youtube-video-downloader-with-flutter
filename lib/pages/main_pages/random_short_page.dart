import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../public_functions.dart';

class RandomShortPage extends StatefulWidget {
  const RandomShortPage({Key? key}) : super(key: key);

  @override
  State<RandomShortPage> createState() => _RandomShortPageState();
}

class _RandomShortPageState extends State<RandomShortPage> {

  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<WebViewController> controller) {
          return WebView(
            initialUrl: 'https://www.youtube.com/shorts/EOJ5Og4YgcQ',
            javascriptMode: JavascriptMode.unrestricted,
            allowsInlineMediaPlayback: true,

            onWebViewCreated: (controller){

              _controller.complete(controller);
            },
            onProgress: (i){
              loge(tag: "TAGATAG",message: i.toString());
            },
            gestureRecognizers: Set()
              ..add(Factory<VerticalDragGestureRecognizer>(()=>VerticalDragGestureRecognizer())),
          );
        }
    );
  }
}
