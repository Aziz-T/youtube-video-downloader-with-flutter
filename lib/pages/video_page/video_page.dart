import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/public_functions.dart';
import '../../providers/video_provider.dart';

class VideoPage extends StatefulWidget {
  final String url;
  const VideoPage({Key? key, required this.url}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  WebViewController? _webViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String url = await _webViewController?.currentUrl()??"";
          context.read<VideoProvider>().downloadVideo(youTubeLink: url, title: "shorts");
        },
        backgroundColor: Colors.red,
        child: Icon(
          Icons.download_rounded,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder<WebViewController>(
          future: _controller.future,
          builder: (context, AsyncSnapshot<WebViewController> controller) {
            return WebView(
              initialUrl:
                  widget.url, //'https://www.youtube.com/shorts/EOJ5Og4YgcQ',
              javascriptMode: JavascriptMode.unrestricted,
              allowsInlineMediaPlayback: true,

              onWebViewCreated: (controller) {
                _controller.complete(controller);
                setState(() {
                  _webViewController = controller;
                });
              },
              onProgress: (i) {
                loge(tag: "TAGATAG", message: i.toString());
              },
              gestureRecognizers: Set()
                ..add(Factory<VerticalDragGestureRecognizer>(
                    () => VerticalDragGestureRecognizer())),
            );
          }),
    );
  }
}
