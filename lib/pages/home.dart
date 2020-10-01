import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_stopwatch/model/provider_data.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>
    with SingleTickerProviderStateMixin {
  static final _textSTOP = "Stop";
  static final _textSTART = "Start";

  static final _textReset = "Reset";

  String _buttonText = _textSTART;
  final _stopWatch = new Stopwatch();
  final _timeout = const Duration(milliseconds: 5);

  AnimationController _animationController;
  Animation _colorAnimation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stopwatch"),
      ),
      body: _buildBody(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
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

  Widget _buildBody() {
    return Consumer<ProviderData>(
      builder: (_, accountData, __) => Container(
        color: _colorAnimation.value,
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
                    accountData.stopWatchText,
                    style: TextStyle(
                      fontSize: 72,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
    Provider.of<ProviderData>(context, listen: false).stopWatchText =
        (_stopWatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
            ":" +
            (_stopWatch.elapsed.inSeconds % 60).toString().padLeft(2, "0") +
            ":" +
            (_stopWatch.elapsed.inMilliseconds % 100)
                .toString()
                .padLeft(2, "0");
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
