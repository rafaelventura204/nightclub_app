import 'package:bar_pub/services/wrapper.dart';
import 'package:flutter/material.dart';

class Get {
  static void to(Object context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Wrapper()),
    );
  }
}
