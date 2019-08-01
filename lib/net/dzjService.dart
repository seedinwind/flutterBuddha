import 'dioUtils.dart';
import 'dart:async';
import 'package:dio/dio.dart';


class DzjService{

  Future<Response> getBulist(String biming) async{
    return await DioClient.getClient().dio.get("dzj/content/bu",queryParameters:{"buming":biming});
  }


  Future<Response> getJingDetail(String jingti,String yizhe, int page) async{
    return await DioClient.getClient().dio.get("dzj",queryParameters:{"jingti":jingti,"yizhe":yizhe,"page":page});
  }

  Future<Response> getContent() async{
    return await DioClient.getClient().dio.get("dzj/content");
  }
}