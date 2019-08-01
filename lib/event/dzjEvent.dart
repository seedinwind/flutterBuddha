import 'event.dart';
import 'package:meta/meta.dart';

class DzjContentEvent extends Event{
  var type=DzjContentEventType.Bu;
  var buming="";
  DzjContentEvent(this.type,{this.buming});
}

enum DzjContentEventType{
  Bu,
  Jing
}


class TitleChangeEvent extends Event{
  String title;
  TitleChangeEvent(this.title);
}


class DzjDetailEvent extends Event{
  var jingti="";
  var page = 0;

  String yizhe;
  DzjDetailEvent( this.jingti,this.yizhe,this.page);
}