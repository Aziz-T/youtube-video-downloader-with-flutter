import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:shortviewer/pages/video_download_page/video_download_page.dart';
import 'package:shortviewer/providers/video_provider.dart';
import 'package:shortviewer/widgets/main_button/main_button.dart';
import 'pages/home_navigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => VideoProvider()),
      ],
      child: GetMaterialApp(
        title: 'Short Video Viewer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
      width: _size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              child: Image.asset(
            "assets/ic_launcher.png",
            height: _size.height * 0.3,
          )),
          buildPlayButton(
            context,
            onTap: () async {
              Get.to(() => const HomeNavigator());
            },
          ),
          SizedBox(
            height: 20,
          ),
          buildDownloadButton(
            context,
            onTap: () async {
              Get.to(() => const VideoDownloadPage());
            },
          ),
        ],
      ),
    ));
  }

  Widget buildPlayButton(BuildContext context, {required VoidCallback onTap}) {
    final _size = MediaQuery.of(context).size;
    return MainButton(
      width: _size.width * 0.6,
      onTap: onTap,
      color: Colors.red,
      title: "Watch",
    );
  }

  Widget buildDownloadButton(BuildContext context,
      {required VoidCallback onTap}) {
    final _size = MediaQuery.of(context).size;
    return MainButton(
      width: _size.width * 0.6,
      onTap: onTap,
      color: Colors.green,
      title: "Download Video",
    );
  }
}
/* FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<WebViewController> controller) {
          return WebView(

            initialUrl: 'https://www.youtube.com/shorts/EOJ5Og4YgcQ',
            javascriptMode: JavascriptMode.unrestricted,
            allowsInlineMediaPlayback: true,

            onWebViewCreated: (controller){
              _controller.complete(controller);
            },
            gestureRecognizers: Set()
              ..add(Factory<VerticalDragGestureRecognizer>(()=>VerticalDragGestureRecognizer())),
          );
        }
      ),*/
