import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'format.dart';

import 'package:localstorage/localstorage.dart';

enum app_state {
  stopped,
  started,
}

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
  late Timer _timer = Timer(Duration(), () {});
  bool _isSet = false;
  bool _initialized = false;
  List<int> _laps = [];
  LocalStorage storage = LocalStorage('flutter_stopwatch');

  void _increment(Timer timer) {
    if (_timer.isActive) {
      setState(() {
        _duration++;
      });
    }
  }

  void _store(String key, value) {
    storage.setItem(key, value);
  }

  void _start() {
      if (!_isSet) {
        _timer = Timer.periodic(Duration(milliseconds: 10), _increment);
        _isSet = true;
      }
      if (_initialized) {
        _store('state', app_state.started.index);
        _store('startedAt', DateTime.now().millisecondsSinceEpoch ~/ 10);
      }
  }

  void _stop() {
    _store('state', app_state.stopped.index);
    _store('duration', _duration);
    if (_initialized) {
      _isSet = false;
      _timer.cancel();
    }
  }

  void _reset() {
    storage.clear();
    setState(() {
      _duration = 0;
      _laps = [];
    });
  }

  void _lap() {
    int value = _laps.length == 0
        ? _duration
        : _duration - _laps.reduce((a, b) => a + b);
    if (_isSet) {
      setState(() {
        _laps.add(value);
        _store('laps', _laps);
      });
    }
  }

  void _init(LocalStorage localStorage) {
    var state = localStorage.getItem('state');
    var startedAt = localStorage.getItem('startedAt');
    var duration = localStorage.getItem('duration');
    var laps = localStorage.getItem('laps');

    switch (state) {
      case 1: _duration = startedAt is int ? (DateTime.now().millisecondsSinceEpoch ~/ 10) - startedAt : 0;
      _start();
        break;
      case 0: _duration = duration is int ? duration : 0;
        break;
      default: break;
    }
    _laps = laps is List<dynamic> ? laps.map((e) => e as int).toList() : [];
    return;
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
        minimumSize: Size(100, 40), textStyle: const TextStyle(fontSize: 18));

    Widget loading = LinearProgressIndicator();

    Widget application = Column(children: <Widget>[
        Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Text(elapsedTime(_duration),
          key: Key('duration'),
          style: TextStyle(
            fontSize: 40,
          ))
        ),
        Container(
            padding: EdgeInsets.all(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    key: Key('lap-reset'),
                    style: buttonStyle,
                    onPressed: () {
                      _isSet || (_laps.length == 0 && _duration == 0)
                          ? _lap()
                          : _reset();
                    },
                    child:
                    Text(_isSet || (_laps.length == 0 && _duration == 0)
                        ? 'Lap'
                        : 'Reset')),
                ElevatedButton(
                    key: Key('start-stop'),
                    style: buttonStyle,
                    onPressed: () {
                      setState(() {
                        _isSet ? _stop() :
                          _start();
                        });
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
                            .map((entry) =>
                            Card(
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
      ]);


    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Stopwatch'),
        ),
        body: FutureBuilder(
            future: storage.ready,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text(
                    'Uh Oh! There was an error: ${snapshot.error.toString()}');
              }

              if (!snapshot.hasData) {
                return loading;
              }

              if (snapshot.hasData) {
                if (!_initialized) {
                  _init(storage);
                  _initialized = true;
                }
                return application;
              }
              return application;
            }
        )
    );
  }
}
