
import 'package:flutter/material.dart';


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
        child:RichText(
          text: TextSpan(
            text: '${requiredhits}',
          ),
        ),
      ),
    ) ;
  }
}
