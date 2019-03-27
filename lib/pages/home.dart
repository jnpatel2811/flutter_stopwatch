import 'dart:async';

import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>
    with SingleTickerProviderStateMixin {
  String _stopwatchText = "00:00:00";
  String _buttonText = _textSTART;

  final _stopWatch = new Stopwatch();
  final _timeout = const Duration(milliseconds: 5);

  static final _textSTOP = "Stop";
  static final _textSTART = "Start";
  static final _textReset = "Reset";

  AnimationController _animationController;
  Animation _colorAnimation;


  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _colorAnimation =
        ColorTween(begin: Color(0xff3CA55C), end: Color(0xffB5AC49))
            .animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stopwatch"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      color: _colorAnimation.value,
      /*decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff3CA55C), Color(0xffB5AC49)],
            begin: Alignment.bottomCenter,
          )),*/
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    onPressed: _startStopBtnClicked,
                    child: Text(_buttonText),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  RaisedButton(
                    onPressed: _resetBtnClicked,
                    child: Text(_textReset),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.none,
                child: Text(
                  _stopwatchText,
                  style: TextStyle(
                    fontSize: 72,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTimeout() {
    if (_stopWatch.isRunning) {
      _startTimeout();
    }
    setState(() {
      _setStopwatchText();
    });
  }

  void _resetBtnClicked() {
    if (_stopWatch.isRunning) {
      _startStopBtnClicked();
    }
    setState(() {
      _stopWatch.reset();
      _setStopwatchText();
    });
  }

  void _setStopwatchText() {
    _stopwatchText = (_stopWatch.elapsed.inMinutes % 60)
            .toString()
            .padLeft(2, "0") +
        ":" +
        (_stopWatch.elapsed.inSeconds % 60).toString().padLeft(2, "0") +
        ":" +
        (_stopWatch.elapsed.inMilliseconds % 100).toString().padLeft(2, "0");
  }

  void _startStopBtnClicked() {
    setState(() {
      if (_stopWatch.isRunning) {
        _buttonText = _textSTART;
        _stopWatch.stop();
        _animationController.stop();
      } else {
        _buttonText = _textSTOP;
        _stopWatch.start();
        _startTimeout();
        _animationController.forward();
      }
    });
  }

  void _startTimeout() {
    new Timer(_timeout, _handleTimeout);
  }
}
