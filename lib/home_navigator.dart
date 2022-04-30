import 'dart:async';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortviewer/strings_const.dart';
import 'package:shortviewer/video_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'colors.dart';

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({Key? key}) : super(key: key);

  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {

  // String apiKey = "AIzaSyCqqV1dh0YSlhAMnXkKLHSfpzdEoJv1Dhg";
  // String url = "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=25&q=shorts&key="+apiKey;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.watch<VideoProvider>().currentPage,
      bottomNavigationBar: buildBottomNavyBar(context),
    );
  }

  BottomNavyBar buildBottomNavyBar(BuildContext context) {
    return BottomNavyBar(
      selectedIndex: context.watch<VideoProvider>().selectedIndex,
      showElevation: true, // use this to remove appBar's elevation
      onItemSelected: (index) {
        context.read<VideoProvider>().setPage(index);
      },
      items: [
        BottomNavyBarItem(
          icon: const Icon(Icons.list_alt),
          title: const Text(Strings.homePageTitle),
          activeColor: PalettePrimary.orchid,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.play_arrow_outlined),
          title: const Text(Strings.datePageTitle),
          activeColor: PalettePrimary.darkViolet,
        ),
        BottomNavyBarItem(
            icon: const Icon(Icons.settings),
            title: const Text(Strings.settingsPageTitle),
            activeColor: Colors.blue
        ),
      ],
    );
  }



}
