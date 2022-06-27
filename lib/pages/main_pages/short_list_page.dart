import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:shortviewer/providers/video_provider.dart';

import '../../widgets/main_button/main_button.dart';
import '../../widgets/short_item/short_item.dart';

class ShortListPage extends StatefulWidget {
  const ShortListPage({Key? key}) : super(key: key);

  @override
  State<ShortListPage> createState() => _ShortListPageState();
}

class _ShortListPageState extends State<ShortListPage> {
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
        "Download Video",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          buildDownloadTextField(),
          buildDownloadMainButton(_size),
          SizedBox(height: 12,),
          Row(
            children: [
              SizedBox(width: 10),
              Text("Short Videos",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 12,),
          Expanded(
            child: GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: 1,
              // Generate 100 widgets that display their index in the List.
              children: List.generate(
                  context.watch<VideoProvider>().videoModelList != null
                      ? context.watch<VideoProvider>().videoModelList!.length
                      : 0, (index) {
                return ShortItem(
                  imageUrl: context
                          .watch<VideoProvider>()
                          .videoModelList![index]
                          .imgUrl ??
                      "",
                  title: context
                          .watch<VideoProvider>()
                          .videoModelList![index]
                          .title ??
                      "",
                  url: context
                          .watch<VideoProvider>()
                          .videoModelList![index]
                          .id ??
                      "",
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  MainButton buildDownloadMainButton(Size size) => MainButton(
        onTap: () {
          context.read<VideoProvider>().permissionHandle();
          if (_key.currentState!.validate()) {
            context.read<VideoProvider>().downloadVideo(
                youTubeLink: textEditingController.text.trim(),
                title: "youtubeVideo",
                added: true);
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
        child: Form(
          key: _key,
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
        ),
      );
}
