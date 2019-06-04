import 'package:dio/dio.dart';
import 'dart:async';

class PoemBloc {
  void _getHttp() async {
    try {
      Response response =
          await Dio().get("http://47.94.95.216/content/poem/author");
      _outController.sink.add(response);
    } catch (e) {
      print(e);
    }
  }

  StreamController<int> _userController = StreamController();

  StreamController<Response> _outController = StreamController<Response>();

  Stream<Response> get dataStream => _outController.stream;

  void fetchInitData() {
    _userController.sink.add(null);
    _userController.stream.listen(_onData);
  }

  void _onData(data) {
    _getHttp();
  }
}
