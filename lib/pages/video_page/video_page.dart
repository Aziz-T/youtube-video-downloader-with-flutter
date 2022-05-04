import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../public_functions.dart';

class VideoPage extends StatefulWidget {
  final String url;
  const VideoPage({Key? key, required this.url}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<WebViewController> controller) {
          return WebView(
            initialUrl: widget.url, //'https://www.youtube.com/shorts/EOJ5Og4YgcQ',
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
