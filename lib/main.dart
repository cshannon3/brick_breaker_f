import 'dart:math';

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
              // ...
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

  List<int> randomlyfilledin = [];
  double initballX;
  double initballY;
  Random random;
  List<int> randomlyrequiredhits = [];
  AnimationController controller;
  Animation<double> animation;
  double wallvalue = 0.0;
  double currentvalue = 0.0;



  @override
  void initState() {
    super.initState();
    random = new Random();
    while (randomlyfilledin.length < 20) {
      int val = random.nextInt(120);
      if (!randomlyfilledin.contains(val)) {
        randomlyfilledin.add(val);
        randomlyrequiredhits.add(random.nextInt(8)+1);
      }
    }
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    controller = new AnimationController(
        vsync: this, duration: Duration(seconds: 10))
      ..addListener(() {
      setState(() {});
      }
      );
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      initballX=(MediaQuery.of(context).size.width-45.0)/2;
      initballY = MediaQuery.of(context).size.height-130.0;
    });
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
                        children: List.generate(120, (index) {
                          return randomlyfilledin.contains(index)?
                              Block(location: index, requiredhits: randomlyrequiredhits[randomlyfilledin.indexOf(index)],)
                           : Container();
                        })
                    ),
                    Transform(
                        transform: Matrix4.translationValues(initballX + controller.value*50,initballY- controller.value*50, 0.0),
                      child: Container(
                        height: 30.0,
                        width: 30.0,
                        color: Colors.green,
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
class Block extends StatelessWidget {
  final int location;
  final int requiredhits;

  Block({Key key, this.location, this.requiredhits});

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(
          color: Color.lerp( Colors.green, Colors.red, requiredhits/8),
          borderRadius: BorderRadius.circular(3.0),
          border: Border.all(color: Colors.black)
      ),
      child: Center(
        child: Text(
          '${requiredhits}',
        ),
      ),
    ) ;
  }
}
