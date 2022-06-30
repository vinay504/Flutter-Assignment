

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/timer_provider.dart';

class StopWatch extends StatelessWidget {
  static const route = '/stopwatch';
  var timer;
  StopWatch({Key? key, this.timer}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    timer = Provider.of<TimerProvider>(context, listen: false);
    return Scaffold(
      body: StopWatchBody(),
    );
  }

  Widget StopWatchBody() {
    return Consumer<TimerProvider>(
      builder: (context, timeprovider, widget) {
        return Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100),
                    ),
                    border: Border.all(
                      width: 3,
                      color: Colors.green,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${timer.hour} : ' + '${timer.minute} : ' + '${timer.seconds} ',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (timer.startEnable)
                      ?


                  ElevatedButton(
                    onPressed: timer.startTimer,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),

                    ),
                    child: const Icon(Icons.arrow_right_sharp, color: Colors.white, size: 50,),
                  )
                      :  ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),

                    ),
                    child: const Icon(Icons.arrow_right_sharp, color: Colors.black, size: 50,),
                  ),
                  (timer.stopEnable)
                      ? ElevatedButton(
                    onPressed: timer.stopTimer,
                    child: const Icon(Icons.stop, color: Colors.white, size: 50,),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),

                    ),
                  )
                      :  ElevatedButton(
                    onPressed: null,
                    child: const Icon(Icons.stop, color: Colors.black, size: 50,),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),

                    ),
                  ),
                  (timer.continueEnable)
                      ? ElevatedButton(
                    onPressed: timer.continueTimer,
                    child: const Icon(Icons.pause, color: Colors.white, size: 50,),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),

                    ),
                  )
                      : ElevatedButton(
                    onPressed: null,
                    child: const Icon(Icons.pause, color: Colors.black, size: 50,),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),

                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
