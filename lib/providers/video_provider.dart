import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_youtube_downloader/flutter_youtube_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shortviewer/core/network_manager.dart';
import 'package:shortviewer/pages/main_pages/random_short_page.dart';
import 'package:shortviewer/pages/main_pages/short_list_page.dart';
import 'package:shortviewer/core/public_functions.dart';
import 'package:shortviewer/models/video_model.dart';
import '../values/videos/videos_const.dart';

class VideoProvider extends ChangeNotifier {
  static const String apiKey = "AIzaSyD7ptGo-2goXj2XOJ6nOF5WotPE_H_dpw8";
  static const String url =
      "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=25&q=shorts&key=" +
          apiKey;
  static const String shortUrl =
      "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=25&q=shorts&regionCode=TR&type=video&videoCategoryId=42&key=" +
          apiKey;

  // String _extractedLink = 'Loading...';
  //  String youTube_link = "https://www.youtube.com/watch?v=nRhYQlg8fVw";

  VideoModel? videoModel;
  List<VideoModel>? videoModelList = [];

  List<String> urlList = [];

  List<Widget> pages = [
    ShortListPage(),
    RandomShortPage(),
    // SettingsPage()
  ];

  Widget currentPage = const ShortListPage();
  int selectedIndex = 0;

  @override
  void setPage(int index) {
    currentPage = pages[index];
    selectedIndex = index;
    notifyListeners();
  }

  Future<void> getVideoConst() async {
    try {
      VideoConst.shorts.forEach((element) {
        videoModel = VideoModel(
            id: element['id'],
            title: element['title'],
            imgUrl: element['imgUrl']);
        videoModelList?.add(videoModel!);
      });
    } catch (e) {
      loge(tag: "getVideoConst CATCH", message: e.toString());
    }
  }

  Future<void> extractYoutubeLink({required String youTubeLink}) async {
    String link;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      link = await FlutterYoutubeDownloader.extractYoutubeLink(youTubeLink, 18);
    } on PlatformException {
      link = 'Failed to Extract YouTube Video Link.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    // _extractedLink = link;
  }

  Future<void> downloadVideo(
      {required String youTubeLink, required String title, bool added=false}) async {
    String downloadUrl = "";
    if (youTubeLink.contains("shorts")) {
      print("youtube link: ${youTubeLink.split("/")}");
      String mainUrl = "https://www.youtube.com/watch?v=";
      downloadUrl = mainUrl + youTubeLink.split("/").last;
      print("youtube link: ${youTubeLink}");
    } else {
      print("youtube link: ${youTubeLink.split("/")}");
      downloadUrl = youTubeLink;
    }

    if(downloadUrl.contains("https:")&&added){
      urlList.add(downloadUrl);
      notifyListeners();
    }
    // String denme = "https://youtu.be/NyzcLt1ot_w";
    // String denme1 = "https://youtube.com/shorts/QGRob5Akso0?feature=share";
    print("last link: ${downloadUrl}");
    final result =
        await FlutterYoutubeDownloader.downloadVideo(downloadUrl, title, 18);
    print("resılt: $result");
  }

  removeUrlItem(int index){
    if(urlList.isNotEmpty){
      urlList.removeAt(index);
      notifyListeners();
    }
  }


  Future<void> permissionHandle()async {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
    ].request();
  }

  Future<void> getVideoData() async {
    loge(message: "GET DATA");
    try {
     await NetworkManager.instance.dio.get(url).then((value) {
        if (value.statusCode == HttpStatus.ok) {
          loge(message: value.data['items'][0]);
          for (int i = 0; i < 24; i++) {
            videoModel = VideoModel(
                id: value.data['items'][i]['id']['videoId'],
                title: value.data['items'][i]['snippet']['title'],
                imgUrl: value.data['items'][i]['snippet']['thumbnails']
                    ['default']['url']);
            videoModelList?.add(videoModel!);
          }
          videoModelList?.asMap().forEach((key, value) {
            logd(message: {
              "'id'": "'${value.id}'",
              "'title'": "'${value.title}'",
              "'imgUrl'": "'${value.imgUrl}'"
            });
          });
          notifyListeners();
          loge(tag: "videoMdelList", message: videoModelList?.length);
        } else {
          videoModelList = [];
          notifyListeners();
        }
      });
    } catch (e) {
      loge(tag: "GET VIDEO CATCH", message: e.toString());
    }
  }
}
