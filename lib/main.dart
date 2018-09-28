import 'dart:async';
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

  double currentvalueX = 0.0;
  double currentvalueY = 690.0;
  int currentindexspace = 0;
  Timer timer;
  Stopwatch stopwatch = Stopwatch();
  int indexspace = 0;
  int wait = 0;



  bool right  =true;
  bool up = true;

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
    print(randomlyfilledin);

  }
   startball() {
    currentvalueX = 0.0;
    currentvalueY = 690.0;
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
              if (randomlyrequiredhits[randomlyfilledin.indexOf(indexspace)] ==0 ){
                randomlyfilledin.remove(indexspace);
                randomlyrequiredhits.remove(0);
              }

          }

          else if (currentvalueX < 360 )currentvalueX += 1;
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
             if (randomlyrequiredhits[randomlyfilledin.indexOf(indexspace)] ==0 ){
               randomlyfilledin.remove(indexspace);
               randomlyrequiredhits.remove(0);
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
            if (randomlyrequiredhits[randomlyfilledin.indexOf(indexspace)] ==0 ){
              randomlyfilledin.remove(indexspace);
              randomlyrequiredhits.remove(0);
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
            if (randomlyrequiredhits[randomlyfilledin.indexOf(indexspace)] ==0 ){
              randomlyfilledin.remove(indexspace);
              randomlyrequiredhits.remove(0);
            }
          }
          else
          if (currentvalueY < 690.0)
            currentvalueY += 1;
          else up = true;
        }

      });
      wait +=1;
      //indexspace = ((currentvalueY/40).round()*10+currentvalueX/40.round()%10).round().toInt();

    });
  }

  @override
  Widget build(BuildContext context) {
      //initballX=(MediaQuery.of(context).size.width-45.0)/2;
    //initballX  = 0.0;
    //  initballY = MediaQuery.of(context).size.height-130.0;
     // print(initballY);
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
                          return randomlyfilledin.contains(index)?
                              Block(location: index, requiredhits: randomlyrequiredhits[randomlyfilledin.indexOf(index)],)
                           : Container();
                        })
                    ),
                    Transform(
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
