import 'dart:async';

import 'package:blocpatterndemo/counter_event.dart';

class CounterBloc{
  int _counter = 0;

  final _counterStateController = StreamController<int>();
  StreamSink<int> get _intCounter => _counterStateController.sink;

  Stream<int> get counter => _counterStateController.stream;

  final _counterEventController = StreamController<CounterEvent>();
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc(){
    _counterEventController.stream.listen(_mapEventToStae);
  }


  void _mapEventToStae(CounterEvent event) {
    if (event is IncrementEvent){
      _counter++;
    }else{
      if(_counter != 0){
        _counter --;
      }
    }
    _intCounter.add(_counter);
  }

  void dispose(){
    _counterEventController.close();
    _counterStateController.close();
  }
}
