import 'package:custom_drawer/src/widgets/radial_progress.dart';
import 'package:flutter/material.dart';

class CircularGraphicPage extends StatefulWidget {
  const CircularGraphicPage({Key key}) : super(key: key);

  @override
  _CircularGraphicPageState createState() => _CircularGraphicPageState();
}

class _CircularGraphicPageState extends State<CircularGraphicPage> {
  double percentage = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                percentage += 10;
                if (percentage > 100) {
                  percentage = 0;
                }
              });
            }),
        body: Center(
          child: Container(
            width: 300,
            height: 300,
            child: RadialProgress(
              progressBarColor: Colors.purpleAccent,
              percent: percentage,
            ),
          ),
        ));
  }
}
