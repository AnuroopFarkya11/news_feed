import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class ReelBloc extends Cubit<AsyncSnapshot>{
  ReelBloc(super.initialState);


  void updateSnapshot(AsyncSnapshot snapshot)
  {
    emit(snapshot);
  }

}