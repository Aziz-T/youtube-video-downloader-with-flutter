import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/video_provider.dart';
import '../../widgets/main_button/main_button.dart';
import '../../widgets/url_item/url_item.dart';

class VideoDownloadPage extends StatefulWidget {
  const VideoDownloadPage({Key? key}) : super(key: key);

  @override
  State<VideoDownloadPage> createState() => _VideoDownloadPageState();
}

class _VideoDownloadPageState extends State<VideoDownloadPage> {



  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Download Youtube Video",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          context.watch<VideoProvider>().urlList.length == 0
              ? SizedBox.shrink()
              : Row(
                  children: [
                    SizedBox(width: 10),
                    Text("Latest Downloaded Urls",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
          Flexible(
            child: ListView.builder(
                itemCount: context.read<VideoProvider>().urlList.length,
                itemBuilder: (context, index) {
                  return UrlItem(
                    url: context.watch<VideoProvider>().urlList[index],
                    copyTab: () {
                      Clipboard.setData(ClipboardData(
                          text:
                              context.read<VideoProvider>().urlList[index]));
                    },
                    deleteTab: () {
                      context.read<VideoProvider>().removeUrlItem(index);
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }

}
