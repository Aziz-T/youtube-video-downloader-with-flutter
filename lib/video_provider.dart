


import 'dart:io';


import 'package:flutter/material.dart';
import 'package:shortviewer/network_manager.dart';
import 'package:shortviewer/pages/main_pages/random_short_page.dart';
import 'package:shortviewer/pages/main_pages/settings_page.dart';
import 'package:shortviewer/pages/main_pages/short_list_page.dart';
import 'package:shortviewer/public_functions.dart';
import 'package:shortviewer/video_model.dart';
import 'package:shortviewer/videos/videos_const.dart';

class VideoProvider extends ChangeNotifier{

 static const String apiKey = "AIzaSyD7ptGo-2goXj2XOJ6nOF5WotPE_H_dpw8";
 static const String url = "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=25&q=shorts&key="+apiKey;
 static const String shortUrl = "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=25&q=shorts&regionCode=TR&type=video&videoCategoryId=42&key="+apiKey;

 VideoModel? videoModel;
  List<VideoModel>? videoModelList = [];

 List<Widget> pages =[
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


 Future<void> getVideoConst()async {
   try{
     VideoConst.shorts.forEach((element) {
       videoModel = VideoModel(id: element['id'],
           title: element['title'],
           imgUrl: element['imgUrl']);
       videoModelList?.add( videoModel! );
     });
   }catch(e){
     loge(tag: "getVideoConst CATCH",message: e.toString());
   }
 }



  Future<void> getVideoData() async {
   loge(message: "GET DATA");
   try{
     NetworkManager.instance.dio.get(url).then((value) {
       if(value.statusCode == HttpStatus.ok){
         loge(message: value.data['items'][0]);
         for(int i = 0 ; i < 24 ; i++){
           videoModel = VideoModel(id: value.data['items'][i]['id']['videoId'],
               title: value.data['items'][i]['snippet']['title'],
               imgUrl: value.data['items'][i]['snippet']['thumbnails']['default']['url']);
           videoModelList?.add( videoModel! );

         }
         videoModelList?.asMap().forEach((key, value) {
           logd(message: {
             "'id'": "'${value.id}'",
             "'title'": "'${value.title}'",
             "'imgUrl'": "'${value.imgUrl}'"
           } );
         });
         notifyListeners();
         loge(tag: "videoMdelList",message: videoModelList?.length);
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