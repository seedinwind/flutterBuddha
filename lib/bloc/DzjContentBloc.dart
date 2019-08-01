import 'package:bloc/bloc.dart';
import '../data/datas.dart';
import '../event/events.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import '../state/states.dart';
import '../net/net.dart';


class DzjContentBloc extends Bloc<DzjContentEvent, DzjState> {
  @override
  DzjState get initialState => DzjContentLoading();

  @override
  Stream<DzjState> mapEventToState(DzjContentEvent event) async* {
      yield DzjContentLoading();
      DzjBuList list = await _getHttp();
      yield DzjContentLoaded(content: list);
  }


  Future<DzjBuList> _getHttp() async {
    try {
      Response response =
      await DzjService().getContent();
      print(response.data);

      return DzjBuList.fromJson(response.data);
    } catch (e) {
      print(e);
    }
  }


}
