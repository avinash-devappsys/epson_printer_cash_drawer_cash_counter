import 'package:flutter/material.dart';

class ApplicationData extends ChangeNotifier {
  static final ApplicationData _singleton = ApplicationData._internal();

  factory ApplicationData() {
    return _singleton;
  }

  ApplicationData._internal();

  // Define pairedDevice property
  dynamic _pairedDevice;

  // Getter for pairedDevice
  dynamic get pairedDevice => _pairedDevice;

  // Setter for pairedDevice
  set pairedDevice(dynamic value) {
    _pairedDevice = value;
    notifyListeners();
  }
}
