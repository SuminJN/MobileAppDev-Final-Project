import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({Key? key}) : super(key: key);

  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  Color appColor = const Color.fromRGBO(134, 201, 245, 1);
  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text('Stopwatch'),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 32,
              horizontal: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 80.0,
                ),

                /// Display stop watch time
                StreamBuilder<int>(
                  stream: _stopWatchTimer.rawTime,
                  initialData: _stopWatchTimer.rawTime.value,
                  builder: (context, snap) {
                    final value = snap.data!;
                    final displayTime =
                        StopWatchTimer.getDisplayTime(value, hours: _isHours);
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            displayTime,
                            style: const TextStyle(
                                fontSize: 40,
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 50.0,
                ),

                /// Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: RaisedButton(
                        padding: const EdgeInsets.all(4),
                        color: Colors.lightBlue,
                        shape: const StadiumBorder(),
                        onPressed: () async {
                          _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                        },
                        child: const Text(
                          'Start',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: RaisedButton(
                        padding: const EdgeInsets.all(4),
                        color: Colors.green,
                        shape: const StadiumBorder(),
                        onPressed: () async {
                          _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                        },
                        child: const Text(
                          'Stop',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: RaisedButton(
                        padding: const EdgeInsets.all(4),
                        color: Colors.red,
                        shape: const StadiumBorder(),
                        onPressed: () async {
                          _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                        },
                        child: const Text(
                          'Reset',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(0).copyWith(right: 8),
                        child: RaisedButton(
                          padding: const EdgeInsets.all(4),
                          color: Colors.deepPurpleAccent,
                          shape: const StadiumBorder(),
                          onPressed: () async {
                            _stopWatchTimer.onExecute.add(StopWatchExecute.lap);
                          },
                          child: const Text(
                            'Lap',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 150.0,
                ),

                /// Lap time.
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(
                    height: 100,
                    child: StreamBuilder<List<StopWatchRecord>>(
                      stream: _stopWatchTimer.records,
                      initialData: _stopWatchTimer.records.value,
                      builder: (context, snap) {
                        final value = snap.data!;
                        if (value.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        Future.delayed(const Duration(milliseconds: 100), () {
                          _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeOut);
                        });
                        return ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            final data = value[index];
                            return Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    '${index + 1} ${data.displayTime}',
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Divider(
                                  height: 1,
                                )
                              ],
                            );
                          },
                          itemCount: value.length,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
