import 'package:flutter/material.dart';

class ProviderData extends ChangeNotifier {
  String _stopWatchText = "00:00:00";

  String get stopWatchText => _stopWatchText;

  set stopWatchText(String value) {
    _stopWatchText = value;
    notifyListeners();
  }
}
