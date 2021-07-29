import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Stopwatch App', () {
    final startStopButtonFinder = find.byValueKey('start-stop');
    final lapResetButtonFinder = find.byValueKey('lap-reset');
    final durationFinder = find.byValueKey('duration');
    final lap1Finder = find.byValueKey('lap-0');
    final lap2Finder = find.byValueKey('lap-1');

    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      driver.close();
    });

    test('has Start/Stop button that says Start at render', () async {
      expect(await driver.getText(startStopButtonFinder), 'Start');
    });

    test('increments duration after tapping Start', () async {
       expect(await driver.getText(durationFinder), '00:00:00');
      await Future.delayed(const Duration(seconds: 2), () {});
      await driver.tap(startStopButtonFinder);
      expect(await driver.getText(durationFinder), isNot('00:00:00'));
    });

    test('has Start/Stop button that says Stop after initial tap', () async {
      await driver.tap(startStopButtonFinder);
      expect(await driver.getText(startStopButtonFinder), 'Stop');
    });

    test('creates lap after pressing Lap', () async {
      await driver.tap(startStopButtonFinder);
      expect(await driver.getText(startStopButtonFinder), 'Stop');
      expect(driver.getText(lapResetButtonFinder), 'Lap');
      await driver.tap(lapResetButtonFinder);
      expect(await driver.getText(lap1Finder), 'Lap #1');
    });

    test('creates another lap after pressing Lap', () async {
      await driver.tap(startStopButtonFinder);
      expect(await driver.getText(startStopButtonFinder), 'Stop');
      expect(driver.getText(lapResetButtonFinder), 'Lap');
      await driver.tap(lapResetButtonFinder);
      expect(await driver.getText(lap1Finder), 'Lap #1');
      expect(driver.getText(lapResetButtonFinder), 'Lap');
      await driver.tap(lapResetButtonFinder);
      expect(await driver.getText(lap2Finder), 'Lap #2');
    });
  });
}