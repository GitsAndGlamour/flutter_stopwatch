import 'dart:async';
import 'format.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stopwatch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StopwatchPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StopwatchPage extends StatefulWidget {
  StopwatchPage({Key? key}) : super(key: key);

  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  int _duration = 3665000;
  late Timer _timer;
  bool isSet = false;

  void _increment(Timer timer) {
    if (_timer.isActive) {
      setState(() {
        _duration++;
      });
    }
  }

  void _start() {
    setState(() {
      if (!isSet) {
        _timer = Timer.periodic(Duration(milliseconds: 1), _increment);
        isSet = true;
      }
    });
  }

  void _stop() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle =
    ElevatedButton.styleFrom(
        minimumSize: Size(100, 40),
        textStyle: const TextStyle(fontSize: 18)
    );


    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Stopwatch'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Column(
          children: <Widget>[
            Text(elapsedTime(_duration),
              style: TextStyle(
                fontSize: 40,
              )),
            Container(
              padding:  EdgeInsets.all(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: _stop,
                    child: Text('Stop')),
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: _start,
                    child: Text('Start')),
                ],
              )
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 40, 0, 20),
              child: Text("Made by Omie Walls :)"),
            )
          ],
        ),
      ),
    );
  }
}
