import 'dart:async';

import 'package:flutter/material.dart';

class Ball extends StatefulWidget {
  final List<int> randomlyfilledin;
  final List<int> randomlyrequiredhits;
  final Function() endgame;

  const Ball({Key key, this.randomlyfilledin, this.randomlyrequiredhits, this.endgame}) : super(key: key);

  @override
  _BallState createState() => new _BallState();
}

class _BallState extends State<Ball> {


  double currentvalueX = 0.0;
  double maxYvalue = 620.0;
  double maxXvalue = 360.0;
  double currentvalueY = 620.0;
  Timer timer;
  Stopwatch stopwatch = Stopwatch();
  bool right  =true;
  bool up = true;
  int currentindexspace = 0;
  int indexspace = 0;
  int wait = 0;
  List<int> randomlyfilledin = [];
  List<int> randomlyrequiredhits = [];
  int score= 0;

  @override
  void initState() {
    super.initState();
    randomlyfilledin = widget.randomlyfilledin;
    randomlyrequiredhits = widget.randomlyrequiredhits;
  }

  startball() {
    currentvalueX = 0.0;
    currentvalueY = maxYvalue;

    timer?.cancel(); // cancel old timer if it exists
    //Start new timer
    timer = Timer.periodic(Duration(milliseconds:  2), (Timer timer){
      setState(() {
        if(right &&wait > 1) {
          if (randomlyfilledin.contains(((currentvalueY/40).round()*10+currentvalueX/40.ceil()%10).toInt())&&wait > 10) {
            wait = 0;
            right = false;
            //currentvalueX -= 2;
            print(currentindexspace);
            indexspace = ((currentvalueY/40).round()*10+currentvalueX/40.ceil()%10).toInt();
            randomlyrequiredhits[randomlyfilledin.indexOf(indexspace)] -=1;
            score += 1;
            if (randomlyrequiredhits[randomlyfilledin.indexOf(indexspace)] ==0 ){
              randomlyfilledin.remove(indexspace);
              randomlyrequiredhits.remove(0);
              if(randomlyfilledin.isEmpty) endGame();
            }

          }
          else if (currentvalueX < maxXvalue )currentvalueX += 1;
          else {
            right = false;
          }

        } else if (wait>1) {
          indexspace = ((currentvalueY/40).round()*10+currentvalueX/40.round()%10).toInt();
          if (randomlyfilledin.contains(indexspace) && wait>10) {
            wait = 0;
            right=true;
            currentvalueX += 2;
            randomlyrequiredhits[randomlyfilledin.indexOf(indexspace)] -=1;
            score += 1;
            if (randomlyrequiredhits[randomlyfilledin.indexOf(indexspace)] ==0 ){
              randomlyfilledin.remove(indexspace);
              randomlyrequiredhits.remove(0);
              if(randomlyfilledin.isEmpty) endGame();
            }
          }
          else if (currentvalueX >0 /*&& (!randomlyfilledin.contains(indexspace) || currentindexspace== indexspace)*/) currentvalueX-=1;
          else right = true;

        }
        if(up && wait >1) {
          if (randomlyfilledin.contains(((currentvalueY/40).floor()*10+currentvalueX/40%10.round()).toInt()) && wait>10) {
            // if (randomlyfilledin.contains(indexspace)&& currentindexspace != indexspace) {
            up = false;
            //    currentvalueX += 2;
            wait = 0;
            indexspace = ((currentvalueY/40).floor()*10+currentvalueX/40%10.round()).toInt();
            randomlyrequiredhits[randomlyfilledin.indexOf(indexspace)] -=1;
            score += 1;
            if (randomlyrequiredhits[randomlyfilledin.indexOf(indexspace)] ==0 ){
              randomlyfilledin.remove(indexspace);
              randomlyrequiredhits.remove(0);
              if(randomlyfilledin.isEmpty) endGame();
            }

          }
          else
          if (currentvalueY >0.0) currentvalueY-=1;
          else up = false;

        }else if (wait >1) {
          if (randomlyfilledin.contains(((currentvalueY/40).ceil()*10+currentvalueX/40%10.ceil()).toInt()) && wait>10) {
            //if (randomlyfilledin.contains(indexspace) && currentindexspace != indexspace) {
            up=true;
            wait = 0;
            //   currentvalueX -= 2;
            indexspace = ((currentvalueY/40).ceil()*10+currentvalueX/40%10.ceil()).toInt();
            randomlyrequiredhits[randomlyfilledin.indexOf(indexspace)] -=1;
            score += 1;
            if (randomlyrequiredhits[randomlyfilledin.indexOf(indexspace)] ==0 ){
              randomlyfilledin.remove(indexspace);
              randomlyrequiredhits.remove(0);
              if(randomlyfilledin.isEmpty) endGame();
            }

          }
          else
          if (currentvalueY < maxYvalue)
            currentvalueY += 1;
          else if(score!=0)endGame();
          else up = true;
        }

      });
      wait +=1;
    });
  }
  endGame() {
    timer?.cancel(); // cancel old timer if it exists
    setState(() {
      currentvalueX = 0.0;
      currentvalueY = maxYvalue;
      score = 0;
      widget.endgame;
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Container();
  }


}
