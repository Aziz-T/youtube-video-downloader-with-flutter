import 'package:dio/dio.dart';

class NetworkManager{
  static NetworkManager? _instance;
  static NetworkManager get instance {
    if(_instance!=null) return _instance!;
    _instance = NetworkManager._init();
    return _instance!;
  }
  final String _baseUrl = "https://api.datamuse.com";
  late final Dio dio;

  NetworkManager._init(){
    dio = Dio(BaseOptions(baseUrl: _baseUrl));
  }

}