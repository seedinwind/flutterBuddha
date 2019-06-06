import 'package:bloc/bloc.dart';
import '../data/poem.dart';
import '../event/poemEvent.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import '../state/states.dart';

class PoemBloc extends Bloc<PoemEvent, PoemListState> {

  @override
  PoemListState get initialState => PoemListLoaded(poems:PoemList());

  @override
  Stream<PoemListState> mapEventToState(PoemEvent event) async* {
    PoemList list=await _getHttp();
    yield PoemListLoaded(poems:list);
  }
//TODO 空列表 请求错误处理
  Future<PoemList> _getHttp() async {
    try {
      Response response =
          await Dio().get("http://47.94.95.216/content/poem/author");
      return PoemList.fromJson(response.data);
    } catch (e) {
      print(e);
    }
  }
}
