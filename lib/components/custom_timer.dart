import 'package:flutter/material.dart';
import 'dart:async';

class CustomTimer extends StatefulWidget {
  final int counter;
  final String Function(bool) timerStop;

  const CustomTimer({this.counter, this.timerStop});

  @override
  _CustomTimerState createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {
  bool _disposed = false;
  int _counter;
  Timer _timer;

  @protected
  @mustCallSuper
  void initState() {
    _startTimer(context);
    super.initState();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.timer,
              size: 32.0,
            ),
          ),
          Text(
            '$_counter',
            style: TextStyle(fontSize: 24.0),
          ),
        ],
      ),
    );
  }

  void _startTimer(BuildContext context) {
    _counter = widget.counter;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_disposed) {
        setState(() {
          if (_counter > 0) {
            _counter--;
          } else {
            _timer.cancel();
            widget.timerStop(true);
          }
        });
      }
    });
  }
}
