import 'dart:async';

import 'package:flutter/material.dart';

import 'format.dart';

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
  int _duration = 0;
  late Timer _timer;
  bool _isSet = false;
  List<int> _laps = [];

  void _increment(Timer timer) {
    if (_timer.isActive) {
      setState(() {
        _duration++;
      });
    }
  }

  void _start() {
    setState(() {
      if (!_isSet) {
        _timer = Timer.periodic(Duration(milliseconds: 10), _increment);
        _isSet = true;
      }
    });
  }

  void _stop() {
    _timer.cancel();
    setState(() {
      _isSet = false;
    });
  }

  void _reset() {
    setState(() {
      _duration = 0;
      _laps = [];
    });
  }

  void _lap() {
    int value = _laps.length == 0
        ? _duration
        : _duration - _laps.reduce((a, b) => a + b);
    setState(() {
      _laps.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
        minimumSize: Size(100, 40), textStyle: const TextStyle(fontSize: 18));

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Stopwatch'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Column(children: <Widget>[
          Text(elapsedTime(_duration),
              key: Key('duration'),
              style: TextStyle(
                fontSize: 40,
              )),
          Container(
              padding: EdgeInsets.all(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      key: Key('lap-reset'),
                      style: buttonStyle,
                      onPressed: () {
                        _isSet || (_laps.length == 0 && _duration == 0) ? _lap() : _reset();
                      },
                      child:
                          Text(_isSet || (_laps.length == 0 && _duration == 0) ? 'Lap' : 'Reset')),
                  ElevatedButton(
                      key: Key('start-stop'),
                      style: buttonStyle,
                      onPressed: () {
                        _isSet ? _stop() : _start();
                      },
                      child: Text(_isSet ? 'Stop' : 'Start')),
                ],
              )),
          Expanded(
              flex: 1,
              child: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                          children: _laps
                              .asMap()
                              .entries
                              .map((entry) => Card(
                                    child: ListTile(
                                      title: Text(
                                        'Lap # ${(entry.key + 1).toString()}',
                                        key: Key('lap-${entry.key}'),
                                      ),
                                      trailing: Text(elapsedTime(entry.value)),
                                    ),
                                  ))
                              .toList())))),
          Container(
            margin: EdgeInsets.fromLTRB(0, 40, 0, 20),
            child: Text("Made by Omie Walls :)"),
          )
        ]),
      ),
    );
  }
}
