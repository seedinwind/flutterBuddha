import 'package:dio/dio.dart';


class DioClient{
  Dio dio;
  static DioClient _dioClient;

  DioClient._internal(Dio d){
    dio = d;
  }

  factory DioClient.getClient(){
    if(_dioClient == null){
      var dio = new Dio();
      dio.options.baseUrl="http://47.94.95.216/wise/admin/";
//      dio.options.connectTimeout = 10000; //5s
//      dio.options.receiveTimeout = 10000;
      _dioClient = DioClient._internal(dio);
    }
    return _dioClient;
  }
}