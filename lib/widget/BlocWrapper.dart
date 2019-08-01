import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class BlocWrapper extends StatelessWidget{
  Bloc bloc;
  BlocWidgetBuilder  builder;
  BlocWrapper(Bloc bloc,BlocWidgetBuilder builder){
    this.bloc = bloc;
    this.builder=builder;
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(bloc: bloc,child: BlocBuilder(bloc: bloc, builder: builder));
  }

}