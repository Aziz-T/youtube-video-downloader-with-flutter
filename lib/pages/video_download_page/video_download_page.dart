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
  late TextEditingController textEditingController;
  final _key = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController = TextEditingController();
  }

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
      body: Form(
        key: _key,
        child: Column(
          children: [
            buildDownloadTextField(),
            buildDownloadMainButton(_size),
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
      ),
    );
  }

  MainButton buildDownloadMainButton(Size size) => MainButton(
        onTap: () {
          if (_key.currentState!.validate()) {
            context.read<VideoProvider>().downloadVideo(
                youTubeLink: textEditingController.text.trim(),
                title: "youtubeVideo",added: true);
          }
        },
        height: 56,
        width: size.width * 0.6,
        title: "Download Video",
        hasPadding: false,
        fontSize: 18,
      );

  Widget buildDownloadTextField() => Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          controller: textEditingController,
          validator: (val) {
            if (val != null) {
              if (val.isEmpty) {
                return "Copy video link and paste here!";
              }
            }
          },
          decoration: const InputDecoration(
            border: InputBorder.none,
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
        ),
      );
}
