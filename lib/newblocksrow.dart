

import 'package:brick_breaker_f/blockcontroller.dart';
import 'package:brick_breaker_f/draggableblock.dart';
import 'package:flutter/material.dart';

class NewBlocksRow extends StatelessWidget {
  final BlockController blockController;
  //final List<int> queueblocks;
 // final Function(Offset, int)  onDraggableCanceled;
  const NewBlocksRow({Key key, this.blockController,/*this.queueblocks, this.onDraggableCanceled*/}) : super(key: key);

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
          children: List.generate((blockController.queueblocks.length), (i){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                  child: DraggableBlock(
                    index: i,
                    requiredhits: blockController.queueblocks[i],
                    onDraggableCanceled: (offset, i) {
                      blockController.onDoneDragging(offset, i);
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
