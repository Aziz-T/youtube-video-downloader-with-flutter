import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:shortviewer/video_provider.dart';
import 'home_navigator.dart';

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
        title: 'Flutter Demo',
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
  const MyHomePage({Key? key, }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      body: Center(
        child: InkWell(
            onTap: () async {

              await context.read<VideoProvider>().getVideoData();
              Get.to(()=>HomeNavigator());
            },
            child: Container(
              color: Colors.blue,
              height: 30,width: 40,)),
      )

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