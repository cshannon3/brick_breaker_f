import 'package:brick_breaker_f/block.dart';
import 'package:flutter/material.dart';

class DraggableBlock extends StatelessWidget {

  final int index;
  final int requiredhits;
  final Function(Offset, int) onDraggableCanceled;

  DraggableBlock({Key key, this.index, this.requiredhits, this.onDraggableCanceled});

  @override
  Widget build(BuildContext context) {
    return new Draggable(
      child: Container(
          width: 40.0,
          height: 40.0,
          child: Block(
            location: 0,
            requiredhits: requiredhits,
          )
      ),
      onDraggableCanceled: (velocity, offset){
        onDraggableCanceled(offset, index);
        /*setState(() {
          int spot = (((offset - appbar).dy/40).round()*10+(offset - appbar).dx/40.ceil()%10).toInt();
          if (!randomlyfilledin.contains(spot)) {
            randomlyfilledin.add(spot);
            randomlyrequiredhits.add(queueblocks[i]);
            queueblocks.removeAt(i);
            //queueblocks.add(random.nextInt(8)+1);
            print(queueblocks);
          }

        });*/
      },
      feedback: Container(
          width: 60.0,
          height: 60.0,
          child: Block(
            location: 0,
            requiredhits: requiredhits,
          )
      ),

    );
  }
}
