import 'dart:async';
import 'package:flutter/material.dart';





class Debounce {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;
  Debounce({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!
          .cancel(); // when the user is continuosly typing, this cancels the timer
    }
    // then we will start a new timer looking for the user to stop
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}