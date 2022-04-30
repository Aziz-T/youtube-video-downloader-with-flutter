


import 'dart:io';


import 'package:flutter/material.dart';
import 'package:shortviewer/network_manager.dart';
import 'package:shortviewer/pages/main_pages/random_short_page.dart';
import 'package:shortviewer/pages/main_pages/settings_page.dart';
import 'package:shortviewer/pages/main_pages/short_list_page.dart';
import 'package:shortviewer/public_functions.dart';
import 'package:shortviewer/video_model.dart';

class VideoProvider extends ChangeNotifier{

 static const String apiKey = "AIzaSyCqqV1dh0YSlhAMnXkKLHSfpzdEoJv1Dhg";
 static const String url = "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=25&q=shorts&key="+apiKey;

 VideoModel? videoModel;
  List<VideoModel>? videoModelList;

 List<Widget> pages =[
   ShortListPage(),
   RandomShortPage(),
   SettingsPage()
 ];

 Widget currentPage = const ShortListPage();
 int selectedIndex = 0;

 @override
 void setPage(int index) {
   currentPage = pages[index];
   selectedIndex = index;
   notifyListeners();
 }



  Future<void> getVideoData() async {
   try{
     NetworkManager.instance.dio.get(url).then((value) {
       if(value.statusCode == HttpStatus.ok){
         loge(message: value.data['items'][0]);
         for(int i = 0 ; i < 24 ; i++){
           videoModelList?.add(VideoModel(value.data['items'][i]['id']['videoId'],
               value.data['items'][i]['snippet']['title'],
               value.data['items'][i]['snippet']['thumbnails']['default']['url']));
           loge(message: value.data['items'][i]);
           notifyListeners();
         }
       }else {
         videoModelList = [];
         notifyListeners();
       }

     });
   }catch(e){
     loge(tag: "GET VIDEO CATCH",message: e.toString());
   }

}
}