import 'package:flutter/material.dart';

loge({String? tag, var message}){
  print('${tag??'Loge'} --------------------------------------->>>>>value: ${message}');
}
logd({var message}){
  print(message);
}



