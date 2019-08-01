import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../data/Dzj.dart';

class DzjState extends Equatable{
  DzjState([List props = const []]) : super(props);
}

class DzjContentLoaded extends DzjState{
  var init = true;
  DzjBuList content;
  DzjContentLoaded({@required this.content}):super([content]);
}


class DzjContentLoading extends DzjState{
  DzjContentLoading():super();
}


class DzjContentBuLoaded extends DzjState{
  DzjBuList content;
  DzjContentBuLoaded({@required this.content}):super([content]);
}


class DzjContentBuLoading extends DzjState{
  DzjContentBuLoading():super();
}

class TitleState  extends Equatable{
     String title;
     TitleState(this.title):super([title]);
}

class DzjDetailLoaded extends DzjState{
  DzjDetailList content;
  DzjDetailLoaded({@required this.content}):super([content]);
}

class DzjDetailLoading extends DzjState{
  DzjDetailLoading():super();
}