import 'package:bloc/bloc.dart';
import '../data/Poem.dart';
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

  Future<PoemList> _getHttp() async {
    try {
      Response response =
          await Dio().get("http://47.94.95.216/content/poem/author");
      return PoemList.fromJson(response.data);
    } catch (e) {
      print(e);
    }
  }

  StreamController<PoemList> _outController = StreamController<PoemList>();

  Stream<PoemList> get dataStream => _outController.stream;
}

//class PoemBloc {
//  void _getHttp() async {
//    try {
//      Response response =
//          await Dio().get("http://47.94.95.216/content/poem/author");
//      PoemList poems = PoemList.fromJson(response.data);
//      _outController.sink.add(poems);
//    } catch (e) {
//      print(e);
//    }
//  }
//
//  StreamController<int> _userController = StreamController();
//
//  StreamController<PoemList> _outController = StreamController<PoemList>();
//
//  Stream<PoemList> get dataStream => _outController.stream;
//
//  void fetchInitData() {
//    _userController.sink.add(null);
//    _userController.stream.listen(_onData);
//  }
//
//  void _onData(data) {
//    _getHttp();
//  }
//}
