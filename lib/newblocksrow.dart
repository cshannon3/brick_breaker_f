

import 'package:brick_breaker_f/draggableblock.dart';
import 'package:flutter/material.dart';

class NewBlocksRow extends StatelessWidget {
  final List<int> queueblocks;
  final Function(Offset, int)  onDraggableCanceled;

  const NewBlocksRow({Key key, this.queueblocks, this.onDraggableCanceled}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return new  Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width-16.0,
      color: Colors.orange,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: Container(
        color: Colors.grey,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate((queueblocks.length), (i){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                  child: DraggableBlock(
                    index: i,
                    requiredhits: queueblocks[i],
                    onDraggableCanceled: (offset, i) {
                      onDraggableCanceled(offset, i);
                     /* setState(() {
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
                  )

              ),
            );
          }),
        ),
      ),
    );
  }
}
