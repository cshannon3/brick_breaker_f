


import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class BlockController extends ChangeNotifier {
  final TickerProvider _vsync;

  List<int> _randomlyfilledin = [];
  List<int> _randomlyrequiredhits= [];
  List<int> _queueblocks= [];
  int _score = 0;
  Offset position = Offset(18.0, 669.0);
  Offset appbar = Offset(0.0, 100.0);

  double _gameTime;
  Ticker _gameTicker;

  GameState _gameState = GameState.inactive;

  BlockController({
    vsync,
  })
      : _vsync = vsync;

  @override
  void dispose() {
    if (_gameTicker != null) {
      _gameTicker.dispose();
    }
    super.dispose();
  }

  List<int> get randomlyfilledin => _randomlyfilledin;

  List<int> get randomlyrequiredhits => _randomlyrequiredhits;

  List<int> get queueblocks => _queueblocks;

  int get score => _score;
  GameState get gamestate => _gameState;

  set randomlyrequiredhits(List<int> newValue){
    _randomlyrequiredhits = newValue;
    notifyListeners();
  }

  set randomlyfilledin(List<int> newValue){
    _randomlyfilledin = newValue;
    notifyListeners();
  }

  set gamestate(GameState newValue) {
    _gameState = newValue;
    notifyListeners();
  }


  /*set score(int newValue){
    _score = score;
    notifyListeners();
  }*/

  void addToQueueList() {
    Random random = Random();
    _queueblocks.add(random.nextInt(8)+1);
    notifyListeners();
  }
  void plusone(){
    _score +=1;
    notifyListeners();
  }

  bool isblockfilledin(int index) {
    return _randomlyfilledin.contains(index);
  }

  void makenewlists() {
    Random random = Random();
    _randomlyrequiredhits.clear();
    _randomlyfilledin.clear();
    _queueblocks.clear();
    _score = 0;
    while (_randomlyfilledin.length < 20) {
      int val = random.nextInt(120);
      if (!_randomlyfilledin.contains(val)) {
        _randomlyfilledin.add(val);
        _randomlyrequiredhits.add(random.nextInt(8)+1);
      }
      if (_queueblocks.length < 5){
        _queueblocks.add(random.nextInt(8)+1);
      }
    }
    notifyListeners();
  }

  void onDoneDragging(Offset offset, int i){
    int spot = (((offset - appbar).dy / 40).round() *
        10 + (offset - appbar).dx / 40.ceil() % 10)
        .toInt();
    checkspot(spot, i);
  }
  void checkspot(int spot, int i) {
    if (!_randomlyfilledin.contains(spot)) {
      _randomlyfilledin.add(spot);
      _randomlyrequiredhits.add(queueblocks[i]);
      _queueblocks.removeAt(i);
      print(_queueblocks);
    }
    notifyListeners();
  }

  void startBall(){
    _gameState = GameState.active;
    _gameTime = 0.0;
    _gameTicker = _vsync.createTicker(_gameTick)..start();
  }

  void _gameTick(Duration deltaTime) {
    _gameTime += deltaTime.inMilliseconds.toDouble() / 1000.0;
    print(deltaTime.inMilliseconds);

    if(_gameState == GameState.inactive) {
      _gameTicker
        ..stop()
        ..dispose();
      _gameTicker = null;

     // _state = SpringySliderState.idle;
    }

    notifyListeners();
  }

  void endgame() {

  }

}

enum GameState {
  active,
  inactive,

}