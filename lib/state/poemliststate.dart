import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../data/poem.dart';

abstract class PoemListState extends Equatable {
  PoemListState([List props = const []]) : super(props);
}

class PoemListLoading extends PoemListState{

}

class PoemListLoaded extends PoemListState{
  PoemList poems;
  PoemListLoaded({@required this.poems}):super([poems]);
}

