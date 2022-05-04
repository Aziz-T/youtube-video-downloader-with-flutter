import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortviewer/video_provider.dart';

import '../../widgets/short_item/short_item.dart';

class ShortListPage extends StatefulWidget {
  const ShortListPage({Key? key}) : super(key: key);

  @override
  State<ShortListPage> createState() => _ShortListPageState();
}

class _ShortListPageState extends State<ShortListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        childAspectRatio: 0.7 ,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(context.watch<VideoProvider>().videoModelList!=null ?
        context.watch<VideoProvider>().videoModelList!.length: 0 , (index) {
          return ShortItem(
            imageUrl: context.watch<VideoProvider>().videoModelList![index].imgUrl??"",
          );
        }),
      ),
    );
  }
}
