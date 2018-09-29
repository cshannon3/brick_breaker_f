import 'dart:async';


import 'package:brick_breaker_f/ball.dart';
import 'package:brick_breaker_f/block.dart';
import 'package:brick_breaker_f/blockcontroller.dart';

import 'package:brick_breaker_f/newblocksrow.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar:  PreferredSize(
            preferredSize: Size.fromHeight(50.0), // here the desired height
            child: AppBar(
            ),
        ),
        body: new MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{

  BlockController blockController;
  Timer timer2;
  Stopwatch stopwatch2 = Stopwatch();
  Offset position = Offset(18.0, 669.0);
  Offset appbar = Offset(0.0, 100.0);

  @override
  void initState() {
    super.initState();
    blockController = new BlockController(
      vsync: this
    )..addListener(() {
      setState(() {

      });
    });
    blockController.makenewlists();
  }

  endGame() {
    timer2?.cancel();
    setState(() {
      blockController.makenewlists();
    });
  }

  @override
  Widget build(BuildContext context) {
    return  new Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.blue,
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                  children: <Widget>[
                    // _buildLanes(),
                    GridView.count(
                        crossAxisCount: 10,
                        children: List.generate(170, (index) {
                          return blockController.isblockfilledin(index)?
                              Block(location: index, requiredhits: blockController.randomlyrequiredhits[blockController.randomlyfilledin.indexOf(index)],)
                           : Container();
                        })
                    ),
                   Ball(
                     blockController: blockController,
                     endgame: () {
                       endGame();
                     },
                   ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 40.0,
                        width: 100.0,
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                            text: "${blockController.score}"
                            ),
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 0.0,
                        left: 0.0,
                        child: NewBlocksRow(
                          blockController: blockController,
                        ),
                    ),

                  ]
              ),
            ),
          ),
        ),

      ],
    );
  }
}


