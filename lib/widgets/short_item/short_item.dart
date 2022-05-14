
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortviewer/pages/video_page/video_page.dart';

class ShortItem extends StatelessWidget {
  final String? url;
  final String? title;
  final String? imageUrl;
  const ShortItem({Key? key, this.url, this.title, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(()=>VideoPage(url:'https://www.youtube.com/shorts/${url}'));
      },
      child: Container(
        height: 300,
        color: Colors.grey.withOpacity(0.2),
        child: imageUrl != null ? Image.network(imageUrl!,height: 300,fit: BoxFit.fill,):Icon(Icons.network_cell),
      ),
    );
  }
}
