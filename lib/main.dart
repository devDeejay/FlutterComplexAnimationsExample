import 'package:flutter/material.dart';

import 'SlidingScalingDrawer/SlidingScalingDrawerBasicExample.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevDeejay\'s Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SlidingScalingDrawableBasic(),
    );
  }
}
