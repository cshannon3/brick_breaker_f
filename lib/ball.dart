import 'dart:async';

import 'package:brick_breaker_f/blockcontroller.dart';

import 'package:flutter/material.dart';


class Ball extends StatefulWidget {
  final BlockController blockController;
  final Function() endgame;

  const Ball({Key key, this.blockController, this.endgame}) : super(key: key);

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
  int tick = 0;


  startball() {
    widget.blockController.startBall();
    currentvalueX = 0.0;
    currentvalueY = maxYvalue;
    timer?.cancel();
    timer = Timer.periodic(Duration(milliseconds:  2), (Timer timer){
      setState(() {
        tick+=2;
        if (tick>500) widget.blockController.addToQueueList(); tick = 0;
        if(right &&wait > 1) {
          if (widget.blockController.isblockfilledin(((currentvalueY/40).round()*10+currentvalueX/40.ceil()%10).toInt())&&wait > 10) {
            wait = 0;
            right = false;
            //currentvalueX -= 2;
            print(currentindexspace);
            indexspace = ((currentvalueY/40).round()*10+currentvalueX/40.ceil()%10).toInt();
            widget.blockController.randomlyrequiredhits[widget.blockController.randomlyfilledin.indexOf(indexspace)] -=1;
            widget.blockController.plusone();
            if (widget.blockController.randomlyrequiredhits[widget.blockController.randomlyfilledin.indexOf(indexspace)] ==0 ){
              widget.blockController.randomlyfilledin.remove(indexspace);
              widget.blockController.randomlyrequiredhits.remove(0);
              if(widget.blockController.randomlyfilledin.isEmpty) endGame();
            }

          }
          else if (currentvalueX < maxXvalue )currentvalueX += 1;
          else {
            right = false;
          }

        } else if (wait>1) {
          indexspace = ((currentvalueY/40).round()*10+currentvalueX/40.round()%10).toInt();
          if (widget.blockController.randomlyfilledin.contains(indexspace) && wait>10) {
            wait = 0;
            right=true;
            currentvalueX += 2;
            widget.blockController.randomlyrequiredhits[widget.blockController.randomlyfilledin.indexOf(indexspace)] -=1;
            widget.blockController.plusone();
            if (widget.blockController.randomlyrequiredhits[widget.blockController.randomlyfilledin.indexOf(indexspace)] ==0 ){
              widget.blockController.randomlyfilledin.remove(indexspace);
              widget.blockController.randomlyrequiredhits.remove(0);
              if(widget.blockController.randomlyfilledin.isEmpty) endGame();
            }
          }
          else if (currentvalueX >0 /*&& (!randomlyfilledin.contains(indexspace) || currentindexspace== indexspace)*/) currentvalueX-=1;
          else right = true;

        }
        if(up && wait >1) {
          if (widget.blockController.randomlyfilledin.contains(((currentvalueY/40).floor()*10+currentvalueX/40%10.round()).toInt()) && wait>10) {
            // if (randomlyfilledin.contains(indexspace)&& currentindexspace != indexspace) {
            up = false;
            //    currentvalueX += 2;
            wait = 0;
            indexspace = ((currentvalueY/40).floor()*10+currentvalueX/40%10.round()).toInt();
            widget.blockController.randomlyrequiredhits[widget.blockController.randomlyfilledin.indexOf(indexspace)] -=1;
            widget.blockController.plusone();
            if (widget.blockController.randomlyrequiredhits[widget.blockController.randomlyfilledin.indexOf(indexspace)] ==0 ){
              widget.blockController.randomlyfilledin.remove(indexspace);
              widget.blockController.randomlyrequiredhits.remove(0);
              if(widget.blockController.randomlyfilledin.isEmpty) endGame();
            }

          }
          else
          if (currentvalueY >0.0) currentvalueY-=1;
          else up = false;

        }else if (wait >1) {
          if (widget.blockController.randomlyfilledin.contains(((currentvalueY/40).ceil()*10+currentvalueX/40%10.ceil()).toInt()) && wait>10) {
            //if (randomlyfilledin.contains(indexspace) && currentindexspace != indexspace) {
            up=true;
            wait = 0;
            //   currentvalueX -= 2;
            indexspace = ((currentvalueY/40).ceil()*10+currentvalueX/40%10.ceil()).toInt();
            widget.blockController.randomlyrequiredhits[widget.blockController.randomlyfilledin.indexOf(indexspace)] -=1;
            widget.blockController.plusone();
            if (widget.blockController.randomlyrequiredhits[widget.blockController.randomlyfilledin.indexOf(indexspace)] ==0 ){
              widget.blockController.randomlyfilledin.remove(indexspace);
              widget.blockController.randomlyrequiredhits.remove(0);
              if(widget.blockController.randomlyfilledin.isEmpty) endGame();
            }

          }
          else
          if (currentvalueY < maxYvalue)
            currentvalueY += 1;
          else if(widget.blockController.score!=0)endGame();
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
      //widget.blockController.score = 0;
      widget.endgame;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Transform(
          transform: Matrix4.translationValues(/*initballX + controller.value*50*/ currentvalueX,currentvalueY/*- controller.value*50*/, 0.0),
          child: Container(
            height: 30.0,
            width: 30.0,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {startball();},
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            height: 40.0,
            width: 100.0,
            child: Center(
              child: RichText(
                text: TextSpan(
                    text: "${widget.blockController.score}"
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
