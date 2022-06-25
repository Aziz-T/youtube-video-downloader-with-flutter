import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortviewer/providers/video_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/public_functions.dart';

class RandomShortPage extends StatefulWidget {
  const RandomShortPage({Key? key}) : super(key: key);

  @override
  State<RandomShortPage> createState() => _RandomShortPageState();
}

class _RandomShortPageState extends State<RandomShortPage> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  WebViewController? webViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String videoUrl = await webViewController?.currentUrl()??"";
          context.read<VideoProvider>().downloadVideo(
              youTubeLink: videoUrl, title: "Youtube Video Download");
        },
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.download_rounded,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder<WebViewController>(
          future: _controller.future,
          builder: (context, AsyncSnapshot<WebViewController> controller) {
            return WebView(
              initialUrl:
                  'https://www.youtube.com/shorts/${context.read<VideoProvider>().videoModelList?.first.id}',
              //  ??'https://www.youtube.com/shorts/EOJ5Og4YgcQ',
              javascriptMode: JavascriptMode.unrestricted,
              allowsInlineMediaPlayback: true,

              onWebViewCreated: (controller) {
                _controller.complete(controller);
                setState(() {
                  webViewController = controller;
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
