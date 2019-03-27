import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String _stopwatchText = "00:00:00";
  String _buttonText = "Start";

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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  onPressed: _startStopBtnClicked,
                  child: Text(_buttonText),
                ),
                RaisedButton(
                  onPressed: _resetBtnClicked,
                  child: Text("Reset"),
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
    );
  }

  void _startStopBtnClicked() {}

  void _resetBtnClicked() {}
}
